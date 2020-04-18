<?php

namespace App\Http\Controllers;

use App\Http\Resources\EmailModel as EmailResource;
use App\EmailModel;
use App\Providers\Functions;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

class ParameterController extends Controller
{
    public function index()
    {
        $emailModels = EmailModel::where('type', 'LIKE', '%%')
            ->orderBy('id', 'asc')
            ->get();

        return view('admin.parameters', [
            'page' => 'parameters',
            'sub_page' => 'parameters.index',
            'email_models' => $emailModels
        ]);
    }

    public function updateEmailModels(Request $request){
        $data = $request->validate([
            'object' => ['required'],
            'sender_name' => ['required'],
            'sender_email' => ['required'],
            'second_receiver' => [],
            'body' => ['required'],
        ]);

        $model = EmailModel::findOrFail($request->id);

        try{
            $model->object = $data['object'];
            $model->sender_name = $data['sender_name'];
            $model->sender_email = $data['sender_email'];
            $model->second_receiver = $data['second_receiver'];
            $model->body = $data['body'];

            $model->save();
        }catch (Exception $e){
            return new JsonResponse(['message'=>$e->getMessage()], 400);
        }

        return new EmailResource($model);

    }

    public function emailTest(Request $request){
        $information = Functions::informations();
        $model = EmailModel::find($request->id);
        $authUser = Auth::user();

        //[devis-numero] : Remplacé par le numéro du devis
        //[facture-numero] : Remplacé par le numéro de la facture
        //[nomprenom-utilisateur] : Remplacé par le prénom et le nom de l'utilisateur
        //[email-utilisateur] : Remplacé par le mail de l'utilisateur
        //[lien-html] : Renverra un lien vers votre devis au format HTML.
        //[lien-pdf] : Renverra un lien vers votre devis au format PDF.
        //[interlocuteur-nom] : Renverra le nom du collaborateur ayant généré ce devis.
        //[contact-nom] : Renverra le nom du contact client noté sur ce devis.

        $senderName = $model->sender_name;
        if(strstr($model->sender_name, '[nomprenom-utilisateur]'))
            $senderName = $authUser->name." ".$authUser->firstname;

        $senderEmail = $model->sender_email;
        if(strstr($model->sender_email, '[email-utilisateur]'))
            $senderEmail = $authUser->email;

        $receiverName = $authUser->name." ".$authUser->firstname;
        $receiverEmail = $authUser->email;
        $object = $model->object;
        $body = $model->body;

        try{
            Mail::send('emails.test', [
                'body' => $body
            ], function($message) use ($model, $senderName, $senderEmail, $receiverName, $receiverEmail, $object, $body) {
                $message->to($receiverEmail, $receiverName)
                    ->subject($object);
                $message->from($senderEmail, $senderName);
            });
        }catch (Exception $ex){
            return new JsonResponse(['message'=>$ex->getMessage()], 400);
        }

        return new JsonResponse('ok');
    }
}

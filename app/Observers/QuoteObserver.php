<?php

namespace App\Observers;

use App\Quote;

class QuoteObserver
{
    /**
     * Handle the quote "retrieved" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function retrieved(Quote $quote)
    {
//        $now = new \DateTime();
//        $interval = $quote->expire_at->diff($now);
//
//        if($interval->invert == 0){
//            $quote->expired = true;
//            $quote->save();
//        }
    }

    /**
     * Handle the quote "created" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function created(Quote $quote)
    {
        //
    }

    /**
     * Handle the quote "updated" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function updated(Quote $quote)
    {
        //
    }

    /**
     * Handle the quote "deleting" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function deleting(Quote $quote)
    {
        foreach ($quote->items as $item){
            $item->delete();
        }
    }


    /**
     * Handle the quote "deleted" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function deleted(Quote $quote)
    {
        //
    }

    /**
     * Handle the quote "restored" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function restored(Quote $quote)
    {
        //
    }

    /**
     * Handle the quote "force deleted" event.
     *
     * @param  \App\Quote  $quote
     * @return void
     */
    public function forceDeleted(Quote $quote)
    {
        //
    }
}

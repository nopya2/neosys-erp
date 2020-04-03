<?php

namespace App\Imports;

use App\Engagement;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use App\Providers\Functions;

class EngagementsImport implements ToCollection
{
    /**
     * @param array $row
     *
     * @return Engagement|null
     */
    public function collection(Collection $rows)
    {
        foreach ($rows as $row)
        {
            //On chercche dans la table engagements si il existe un engagement ayant le meme numero
            //de devis n_devis
            $search = Engagement::where('n_devis', '=', $row[26])
                ->orderBy('id', 'DESC')
                ->first();
            if(!empty($search)){
                //On verifie d'abord que l'engagement ayant le meme numero d'engagement n'existe pas
                //deja dans la base de donnees
                $s = Engagement::where('n_engage', '=', $row[11])
                    ->orderBy('id', 'DESC')
                    ->first();
                if(empty($s)){
                    //on va donc creer l'engagement comme un reengagement
                    Engagement::create([
                        'd_exerci'  => intval($row[0]),
                        'c_dest'   => intval($row[1]),
                        'nat_dep'   => $row[2],
                        'l_dep'    => $row[3],
                        'm_dispo'  => doubleval($row[4]),
                        'm_toteng'   => doubleval($row[5]),
                        'm_tengvi'  => doubleval($row[6]),
                        'm_totliq'  => doubleval($row[7]),
                        'm_tordvi'  => doubleval($row[8]),
                        'm_totord'  => doubleval($row[9]),
                        'm_dotini'  => doubleval($row[10]),
                        'n_engage'  => $row[11],
                        'm_engage'  => doubleval($row[12]),
                        'date_depot_ac'  => Functions::stringToDate($row[13]),
                        'date_paiement'  => Functions::stringToDate($row[14]),
                        'm_paye'  => doubleval($row[15]),
                        'd_engage'  => Functions::stringToDate($row[16]),
                        'mois_'  => $row[17],
                        'm_tliqenga'  => doubleval($row[18]),
                        'm_non_paye'  => doubleval($row[19]),
                        'l_depeng'  => $row[21],
                        'l_nmtir'  => $row[22],
                        'n_mattir'  => $row[23],
                        'c_mattir'  => $row[24],
                        'l_chap'  => $row[25],
                        'n_devis'  => $row[26],
                        'r_engage' => 'r',
                        'desc_r_engage' => strval(intval($row[0]) - 1)
                    ]);
                }

            }else{
                //On verifie si l'engagment existe
                $s = Engagement::where('n_engage', '=', $row[11])
                    ->orderBy('id', 'DESC')
                    ->first();
                if(empty($s)){
                    Engagement::create([
                        'd_exerci'  => intval($row[0]),
                        'c_dest'   => intval($row[1]),
                        'nat_dep'   => $row[2],
                        'l_dep'    => $row[3],
                        'm_dispo'  => doubleval($row[4]),
                        'm_toteng'   => doubleval($row[5]),
                        'm_tengvi'  => doubleval($row[6]),
                        'm_totliq'  => doubleval($row[7]),
                        'm_tordvi'  => doubleval($row[8]),
                        'm_totord'  => doubleval($row[9]),
                        'm_dotini'  => doubleval($row[10]),
                        'n_engage'  => $row[11],
                        'm_engage'  => doubleval($row[12]),
                        'date_depot_ac'  => Functions::stringToDate($row[13]),
                        'date_paiement'  => Functions::stringToDate($row[14]),
                        'm_paye'  => doubleval($row[15]),
                        'd_engage'  => Functions::stringToDate($row[16]),
                        'mois_'  => $row[17],
                        'm_tliqenga'  => doubleval($row[18]),
                        'm_non_paye'  => doubleval($row[19]),
                        'l_depeng'  => $row[21],
                        'l_nmtir'  => $row[22],
                        'n_mattir'  => $row[23],
                        'c_mattir'  => $row[24],
                        'l_chap'  => $row[25],
                        'n_devis'  => $row[26],
                    ]);
                }
            }
        }
    }
}
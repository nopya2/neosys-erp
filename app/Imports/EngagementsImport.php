<?php

namespace App\Imports;

use App\Engagement;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use App\Providers\Functions;
use Maatwebsite\Excel\Imports\HeadingRowFormatter;

HeadingRowFormatter::default('none');

class EngagementsImport implements ToCollection, WithHeadingRow
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
            $search = Engagement::where('n_devis', '=', $row['n_devis'])
                ->orderBy('id', 'DESC')
                ->first();
            if(!empty($search)){
                //On verifie d'abord que l'engagement ayant le meme numero d'engagement n'existe pas
                //deja dans la base de donnees
                $s = Engagement::where('n_engage', '=', $row['n_engage'])
                    ->orderBy('id', 'DESC')
                    ->first();
                if(empty($s)){
                    //on va donc creer l'engagement comme un reengagement
                    Engagement::create([
                        'd_exerci'  => intval($row['d_exerci']),
                        'c_dest'   => intval($row['c_dest']),
                        'nat_dep'   => $row['nature de la dépenses'],
                        'l_dep'    => $row['L_dest'],
                        'm_dispo'  => doubleval($row['m_dispo']),
                        'm_toteng'   => doubleval($row['m_toteng']),
                        'm_tengvi'  => doubleval($row['m_tengvi']),
                        'm_totliq'  => doubleval($row['m_totliq']),
                        'm_tordvi'  => doubleval($row['m_tordvi']),
                        'm_totord'  => doubleval($row['m_totord']),
                        'm_dotini'  => doubleval($row['m_dotini']),
                        'n_engage'  => $row['n_engage'],
                        'm_engage'  => doubleval($row['m_engage']),
                        'date_depot_ac'  => Functions::stringToDate($row['dates_dépôt AC ']),
                        'date_paiement'  => Functions::stringToDate($row['dates_paiement']),
                        'm_paye'  => doubleval($row['m_payés']),
                        'd_engage'  => Functions::stringToDate($row['d_engage']),
                        'mois_'  => $row['mois_'],
                        'm_tliqenga'  => doubleval($row['m_tliqenga']),
                        'm_non_paye'  => doubleval($row['m_non payés']),
                        'l_depeng'  => $row['l_depeng'],
                        'l_nmtir'  => $row['l_nmtir'],
                        'n_mattir'  => $row['n_mattir'],
                        'c_mattir'  => $row['c_mattir'],
                        'l_chap'  => $row['l_chap'],
                        'n_devis'  => $row['n_devis'],
                        'r_engage' => 'r',
                        'desc_r_engage' => strval(intval($row['d_exerci']) - 1)
                    ]);
                }

            }else{
                //On verifie si l'engagment existe
                $s = Engagement::where('n_engage', '=', $row['n_engage'])
                    ->orderBy('id', 'DESC')
                    ->first();
                if(empty($s)){
                    Engagement::create([
                        'd_exerci'  => intval($row['d_exerci']),
                        'c_dest'   => intval($row['c_dest']),
                        'nat_dep'   => $row['nature de la dépenses'],
                        'l_dep'    => $row['L_dest'],
                        'm_dispo'  => doubleval($row['m_dispo']),
                        'm_toteng'   => doubleval($row['m_toteng']),
                        'm_tengvi'  => doubleval($row['m_tengvi']),
                        'm_totliq'  => doubleval($row['m_totliq']),
                        'm_tordvi'  => doubleval($row['m_tordvi']),
                        'm_totord'  => doubleval($row['m_totord']),
                        'm_dotini'  => doubleval($row['m_dotini']),
                        'n_engage'  => $row['n_engage'],
                        'm_engage'  => doubleval($row['m_engage']),
                        'date_depot_ac'  => Functions::stringToDate($row['dates_dépôt AC ']),
                        'date_paiement'  => Functions::stringToDate($row['dates_paiement']),
                        'm_paye'  => doubleval($row['m_payés']),
                        'd_engage'  => Functions::stringToDate($row['d_engage']),
                        'mois_'  => $row['mois_'],
                        'm_tliqenga'  => doubleval($row['m_tliqenga']),
                        'm_non_paye'  => doubleval($row['m_non payés']),
                        'l_depeng'  => $row['l_depeng'],
                        'l_nmtir'  => $row['l_nmtir'],
                        'n_mattir'  => $row['n_mattir'],
                        'c_mattir'  => $row['c_mattir'],
                        'l_chap'  => $row['l_chap'],
                        'n_devis'  => $row['n_devis'],
                    ]);
                }
            }
        }
    }

//    public function headingRow(): int
//    {
//        return 2;
//    }
}
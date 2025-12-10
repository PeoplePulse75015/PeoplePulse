
{{ config(
    materialized='table',
    schema='individus',
    alias='individus_agg'
) }}

SELECT
 t00.employee_id,
 t00.age,
 t00.departement,
 t00.poste,
 t00.niveau,
 t11.date_embauche,
 t00.anciennete_annees,
 t00.salaire_annuel,
 t00.performance,
 t00.est_parti,
 t00.statut,
 t00.date_depart,
 t00.mois_depart,
 t01.nb_promotions,
 t01.nb_mobilites_internes,
 t01.mois_depuis_derniere_promo,
 t01.progression_salariale_pct, 
 t01.nb_formations_suivies,
 -- t01.stagnation_detectee, --> valeur 0 partout, donc non incluse
 t01.changement_manager_12mois,
 t01.demande_mutation_refusee,
 t01.potentiel_identifie,
 t02.jours_absents_12mois,
 -- t02.frequence_absences, --> donnée considérée comme mal collectée, décidée comme manquante (décision du 08/12)
 t02.taux_absenteisme,
 t02.motif_principal,
 t02.absences_longue_duree
FROM {{ ref('00_transfo_donnees_rh') }} AS t00
INNER JOIN {{ ref('11_Calcul_mois_embauche') }} AS t11 ON t00.employee_id = t11.employee_id
INNER JOIN {{ ref('01_transfo_historique_carriere') }} AS t01 ON t00.employee_id = t01.employee_id
INNER JOIN {{ ref('02_transfo_absenteisme') }} AS t02 ON t00.employee_id = t02.employee_id





{{ config(
    materialized='view',
    schema='entreprise',
    alias='join_historique_contexte'
) }}

SELECT
 t05.mois_histo AS mois_reference,
 t05.annee,
 t05.trimestre,
 t05.effectif,
 t05.nb_departs,
 t05.nb_embauches,
 t05.taux_turnover_annuel,
 t05.taux_turnover_mensuel,
 t05.periode,
 t05.cout_recrutement_unitaire,
 t05.cout_formation_unitaire,
 t05.cout_indirect_unitaire,
 t05.cout_turnover_mensuel,
 t05.cout_recrutement_total,
 t05.cout_formation_total,
 t05.cout_indirect_total,
 t05.cout_total_mensuel,
 t05.ca_moyen_employe_annuel,
 t05.perte_productivite_pct,
 t05.perte_ca_estimee,
 t07.mois_contexte, --> redondance des données, retirées dans le marts
 t07.trimestre_x, --> redondance des données, retirées dans le marts
 t07.trimestre_y, --> redondance des données, retirées dans le marts
 t07.taux_chomage,
 t07.croissance_pib_trim,
 t07.indice_confiance,
 t07.inflation,
 t07.nb_offres_it,
 t07.salaire_median_it,
 t07.demande_competences_rares,
 t07.tension_recrutement,
 t07.nb_concurrents_actifs,
 t07.ecart_salarial_marche,
 t07.attractivite_relative,
 t07.activite_chasseurs_tetes,
 t07.periode_recrutement_forte,
 t07.periode_evaluations,
 t07.periode_promotions,
 t07.periode_recrutement,
 t07.periode_departs_eleves
FROM {{ ref('05_transfo_histo_mensuel_20_24') }} AS t05
LEFT JOIN {{ ref('07_transfo_donnees_contextuelles') }} AS t07
ON t05.mois_histo = t07.mois_contexte


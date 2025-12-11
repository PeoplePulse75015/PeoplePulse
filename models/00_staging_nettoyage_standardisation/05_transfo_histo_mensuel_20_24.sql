{{ config(
    materialized='view'
) }}
SELECT
    TRIM(mois) AS mois_histo,
    CAST(annee AS INT64) AS annee,
    TRIM(trimestre) AS trimestre,
    CAST(effectif AS INT64) AS effectif,
    CAST(nb_departs AS INT64) AS nb_departs,
    CAST(nb_embauches AS INT64) AS nb_embauches,
    CAST(taux_turnover_annuel AS FLOAT64) AS taux_turnover_annuel,
    CAST(taux_turnover_mensuel AS FLOAT64) AS taux_turnover_mensuel,
    TRIM(periode) AS periode,
    CAST(cout_recrutement_unitaire AS INT64) AS cout_recrutement_unitaire,
    CAST(cout_formation_unitaire AS INT64) AS cout_formation_unitaire,
    CAST(cout_indirect_unitaire AS INT64) AS cout_indirect_unitaire,
    CAST(cout_turnover_mensuel AS INT64) AS cout_turnover_mensuel,
    CAST(cout_recrutement_total AS INT64) AS cout_recrutement_total,
    CAST(cout_formation_total AS INT64) AS cout_formation_total,
    CAST(cout_indirect_total AS INT64) AS cout_indirect_total,
    CAST(cout_total_mensuel AS INT64) AS cout_total_mensuel,
    CAST(ca_moyen_employe_annuel AS INT64) AS ca_moyen_employe_annuel,
    CAST(perte_productivite_pct AS FLOAT64) AS perte_productivite_pct,
    CAST(perte_ca_estimee AS INT64) AS perte_ca_estimee
FROM {{ source('company_metadata','historique_mensuel_2020_2024') }}
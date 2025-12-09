SELECT
    CAST(date AS DATE) AS date_evenement_historique,
    TRIM(type) AS type_evenement_historique,
    TRIM(mois) AS mois_evenement_historique,
    CAST(annee AS INT) AS annee_evenement_historique,
    CAST(impact_moral AS INT) AS impact_moral,
    CAST(impact_turnover AS INT) AS impact_turnover,
    TRIM(description) AS description
FROM {{ source('rh_entreprise','evenements_historique_2020_2024') }}
SELECT
    CAST(date AS DATE) AS date_evenement,
    TRIM(type) AS type_evenement,
    TRIM(mois) AS mois_evenement,
    CAST(impact_moral AS INT) AS impact_moral,
    TRIM(departements_concernes) AS departements_concernes
FROM {{ source('entreprise','evenements_entreprises') }}
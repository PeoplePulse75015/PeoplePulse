{{ config(
    materialized='view'
) }}
SELECT
    CAST(date AS DATE) AS date_evenement_historique,
    TRIM(type) AS type_evenement_historique,
    TRIM(mois) AS mois_evenement_historique,
    CAST(annee AS INT64) AS annee_evenement_historique,
    CAST(impact_moral AS INT64) AS impact_moral,
    CAST(impact_turnover AS INT64) AS impact_turnover,
    TRIM(description) AS description
FROM {{ source('company_metadata','evenements_historiques_2020_2024') }}
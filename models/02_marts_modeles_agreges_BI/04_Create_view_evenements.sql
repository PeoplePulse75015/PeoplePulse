
{{ config(
    materialized='table',
    schema='entreprise',
    alias='evenements_agg'
) }}


SELECT
 date_evenement,
 mois_evenement,
 type_evenement,
 impact_moral,
 [departements_concernes] AS departements_concernes,
 NULL AS impact_turnover,
 NULL AS description,
 'Source Evenements' AS table_source
FROM {{ ref('08_transfo_evenements_entreprise') }} 
UNION ALL
SELECT
 date_evenement_historique,
 mois_evenement_historique,
 type_evenement_historique,
 --annee_evenement_historique, --> donnée exclue, connue grâce aux autres dates
 impact_moral,
 CAST(NULL AS ARRAY<STRING>) AS departements_concernes,
 impact_turnover,
 description,
 'Source Evenements historiques' AS table_source
FROM {{ ref('09_transfo_evenements_historiques') }}


{{ config(
    materialized='table',
    schema='peoplepulse',
    alias='historique_contexte'
) }}

SELECT * 
EXCEPT (
 mois_contexte, --> redondance des données
 trimestre_x, --> redondance des données
 trimestre_y --> redondance des données
)
FROM {{ ref('02_Join_table_historique_contexte') }}
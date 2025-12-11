{{ config(
    materialized='table',
    schema='peoplepulse',
    alias='individus_all_datas'
) }}

SELECT
    t00.*,                          -- Toutes les colonnes de la table de gauche (y compris t00.employee_id)
    t01.* EXCEPT (employee_id)      -- Toutes les colonnes de la table de droite SAUF employee_id
FROM {{ ref('00_Join_table_individus') }} AS t00
INNER JOIN {{ ref('01_Join_table_perception') }} AS t01 USING (employee_id)

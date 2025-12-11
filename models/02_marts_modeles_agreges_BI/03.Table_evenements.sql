{{ config(
    materialized='table',
    schema='peoplepulse',
    alias='evenements_all_datas'
) }}

SELECT * 
FROM {{ ref('03_Union_evenements') }} 
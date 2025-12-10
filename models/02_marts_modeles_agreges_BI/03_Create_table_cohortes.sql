
{{ config(
    materialized='table',
    schema='entreprise',
    alias='cohortes_agg'
) }}


SELECT *
FROM {{ ref('06_transfo_cohorte') }}

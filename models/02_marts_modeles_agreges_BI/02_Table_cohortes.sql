
{{ config(
    materialized='table',
    schema='peoplepulse',
    alias='cohortes'
) }}


SELECT *
FROM {{ ref('06_transfo_cohorte') }}

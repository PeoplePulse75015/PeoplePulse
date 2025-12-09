{{ config(
    materialized='table',
    schema='individus'
) }}


SELECT
ROW_NUMBER() OVER() AS employee_id, 
FROM {{ source('individus', '...') }}

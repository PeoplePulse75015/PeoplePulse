{{ config(
    materialized='table'
) }}


SELECT
...
FROM {{ source('entreprise', '...') }}

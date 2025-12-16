{{ config(
    materialized='view'
) }}

WITH source_data AS (
    SELECT
        employee_id,
        anciennete_annees,
        statut,
        date_depart
    FROM {{ ref("00_transfo_donnees_rh") }}
),

calcul_base AS (
    SELECT
        employee_id,
        statut,
        date_depart,
        anciennete_annees,
        
        -- --> Pour calculer l'ancienneté, on transforme en FLOAT64, avec arrondi et SAFE_CAST pour le lien avec BigQuery, qu'il puisse gérer l'erreur (si valeur, alors valeur, sinon NULL)
        CAST(ROUND(SAFE_CAST(anciennete_annees AS FLOAT64) * 12) AS INT64) AS anciennete_mois_valeur,
        
        -- On définit la date de référence pour le calcul : en poste = date d'extraction / parti = date de départ
        CASE
            WHEN statut = "Parti" THEN date_depart
            ELSE PARSE_DATE('%Y-%m-%d', '2024-11-01') 
        END AS date_reference_calcul
        
    FROM source_data
)

SELECT
    employee_id,
    anciennete_annees,
    anciennete_mois_valeur AS anciennete_mois,
    date_reference_calcul AS date_jalon,
    
    -- 3. Calcul de la date d'embauche
    --  --> DATE_SUB va calculer l'ancienneté entre la date de référence et l'ancienneté (déclarée en VALEUR MOIS grâce à INTERVAL)
    --  --> DATE_TRUNC va permettre de tronquer le résultat de DATE_SUB au début du mois grâce à MONTH
    DATE_TRUNC(
        DATE_SUB(
            date_reference_calcul, 
            INTERVAL anciennete_mois_valeur MONTH
        ), 
        MONTH
    ) AS date_embauche

FROM calcul_base
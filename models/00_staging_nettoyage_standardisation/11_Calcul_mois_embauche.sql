{{ config(
    materialized='view'
) }}
WITH calcul_base AS (       --  --> 1ère requête pour calculer l'ancienneté
    SELECT
        employee_id,
        anciennete_annees,
                            --  --> Pour calculer l'ancienneté, on transforme en FLOAT64, avec arrondi et SAFE_CAST pour le lien avec BigQuery, qu'il puisse gérer l'erreur (si valeur, alors valeur, sinon NULL)
        CAST(ROUND(SAFE_CAST(anciennete_annees AS FLOAT64) * 12) AS INT64) AS anciennete_mois_valeur,
                            
                            -- --> ici, on met la date d'extraction des données pour jalon de calcul
        PARSE_DATE('%Y-%m-%d', '2024-11-01') AS date_extraction 
    FROM {{ source('peoplepulse_data', 'donnees_rh') }}
)

SELECT                      --  --> Requête qui utilisera la 1ère pour calculer la date d'embauche
    employee_id,
    anciennete_annees,
    anciennete_mois_valeur AS anciennete_mois,
    date_extraction,
    --  --> DATE_SUB va calculer l'ancienneté entre la date de référence et l'ancienneté (déclarée en VALEUR MOIS grâce à INTERVAL)
    --  --> DATE_TRUNC va permettre de tronquer le résultat de DATE_SUB au début du mois grâce à MONTH 
    DATE_TRUNC(
        DATE_SUB(
            date_extraction, 
            INTERVAL anciennete_mois_valeur MONTH
        ), 
        MONTH
    ) AS date_embauche
FROM calcul_base
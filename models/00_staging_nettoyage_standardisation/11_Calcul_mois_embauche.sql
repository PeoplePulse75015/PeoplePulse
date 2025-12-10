SELECT
    employee_id, 
    anciennete_annees, 

    -- Conversion de la colonne en FLOAT64 pour l'utiliser dans la multiplication
    {% set anciennete_float = "SAFE_CAST(anciennete_annees AS FLOAT64)" %}

    -- 1. Calcul du nombre de mois d'ancienneté (en utilisant la valeur convertie)
    CAST(ROUND({{ anciennete_float }} * 12) AS INT64) AS anciennete_mois,
    
    -- 2. Date de référence : 2024-11
    PARSE_DATE('%Y-%m-%d', '2024-11-01') AS date_extraction,

    -- Définition du nombre de mois calculé pour la lisibilité
    {% set anciennete_mois_calcul = "CAST(ROUND(SAFE_CAST(anciennete_annees AS FLOAT64) * 12) AS INT64)" %}

    -- 3. Soustraction du nombre de mois d'ancienneté de la date de référence.
    DATE_TRUNC(
        DATE_SUB(
            PARSE_DATE('%Y-%m-%d', '2024-11-01'), 
            INTERVAL {{ anciennete_mois_calcul }} MONTH
        ), 
        MONTH
    ) AS date_embauche

FROM 
    {{ source('peoplepulse_data', 'donnees_rh') }}
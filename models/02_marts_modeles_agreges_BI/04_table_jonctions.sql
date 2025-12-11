{{ config(
    materialized='table',
    schema='peoplepulse',
    alias='table_faits' 
) }}

WITH
-- 1. Récupération des employés (Dimension)
dim_employes AS (
    SELECT
        employee_id,
        date_embauche,
        -- Définit la date de fin d'activité (date_depart ou aujourd'hui)
        COALESCE(date_depart, CURRENT_DATE()) AS date_depart_ou_actuel
    FROM {{ ref('00_Table_individus') }} 
),

-- 2. Création de la Dimension Temps Mensuelle (Conversion et formats)
dim_temps_mensuel AS (
    SELECT DISTINCT
        -- Conversion en DATE (YYYY-MM-DD, OBLIGATOIRE pour le filtre WHERE)
        PARSE_DATE('%Y-%m-%d', CONCAT(mois_reference, '-01')) AS mois_reference_date,
        
        -- Format STRING YYYY-MM (pour la clé composée et les jointures textuelles)
        mois_reference AS mois_reference_string
    FROM {{ ref('01_Table_Historique_Contexte') }} 
    WHERE 
        mois_reference IS NOT NULL 
        AND SAFE_CAST(CONCAT(mois_reference, '-01') AS DATE) IS NOT NULL
),

-- 3. LOGIQUE CLÉ : Génération de la Grille (employee_id x mois_reference) et Filtrage
-- Crée une ligne pour chaque mois où l'employé était Actif.
employe_mois_actif AS (
    SELECT
        t1.employee_id,
        t2.mois_reference_date,
        t2.mois_reference_string
    FROM dim_employes AS t1
    CROSS JOIN dim_temps_mensuel AS t2
    
    -- Le filtre d'activité :
    WHERE
        -- Début : >= au mois d'embauche
        t2.mois_reference_date >= DATE_TRUNC(t1.date_embauche, MONTH)
        
        -- Fin : Strictement antérieur au mois de départ
        AND t2.mois_reference_date < DATE_TRUNC(t1.date_depart_ou_actuel, MONTH)
)

-- Sélection Finale : Uniquement les clés et les dates
SELECT
    employee_id,
    
    -- Clé primaire unique pour ce snapshot (ID + YYYYMM)
    TO_HEX(MD5(CONCAT(CAST(employee_id AS STRING), '-', mois_reference_string))) AS cle_snapshot_mensuel,
    
    -- Date de référence (format DATE, YYYY-MM-DD)
    mois_reference_date,
    
    -- Clé de jointure textuelle (format STRING, YYYY-MM)
    mois_reference_string
    
FROM employe_mois_actif
{{ config(
    materialized='view'
) }}
SELECT
    TRIM(employee_id) AS employee_id,
    CAST(jours_absents_12mois AS INT64) AS jours_absents_12mois,
    CAST(frequence_absences AS INT64) AS frequence_absences,
    CAST(taux_absenteisme AS FLOAT64) AS taux_absenteisme,
    
    -- Correction d'encodage complète pour le motif
    TRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(motif_principal, 'Ã©', 'é'),
                        'Ã¨', 'è'
                    ),
                    'Ã ', 'à'
                ),
                'â‚¬', '€' -- Ajout du remplacement pour le symbole Euro
            ),
            'Ã§', 'ç'  -- Ajout du remplacement pour la cédille
        )
    ) AS motif_principal,
    
    CASE
        WHEN absences_longue_duree IN (1) THEN TRUE
        WHEN absences_longue_duree IN (0) THEN FALSE
        ELSE NULL
    END AS absences_longue_duree
FROM {{ source('peoplepulse_data','absenteisme') }}
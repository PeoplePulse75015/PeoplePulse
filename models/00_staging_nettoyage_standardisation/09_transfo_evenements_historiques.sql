{{ config(
    materialized='view'
) }}
SELECT
    CAST(date AS DATE) AS date_evenement_historique,
    
    -- Nettoyage du TYPE d'événement historique
    TRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(type, 'Ã©', 'é'),
                        'Ã¨', 'è'
                    ),
                    'Ã ', 'à'
                ),
                'âš ï¸ ', '⚠️'  -- Correction de l'émoji alerte
            ),
            'â‚¬', '€'    -- Correction du symbole Euro
        )
    ) AS type_evenement_historique,
    
    TRIM(mois) AS mois_evenement_historique,
    CAST(annee AS INT64) AS annee_evenement_historique,
    CAST(impact_moral AS INT64) AS impact_moral,
    CAST(impact_turnover AS INT64) AS impact_turnover,
    
    -- Nettoyage de la DESCRIPTION
    TRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(description, 'Ã©', 'é'),
                        'Ã¨', 'è'
                    ),
                    'Ã ', 'à'
                ),
                'âš ï¸ ', '⚠️' -- Correction de l'émoji alerte
            ),
            'â‚¬', '€'    -- Correction du symbole Euro
        )
    ) AS description
    
FROM {{ source('company_metadata','evenements_historiques_2020_2024') }}
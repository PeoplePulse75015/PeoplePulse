{{ config(
    materialized='view'
) }}
SELECT
    CAST(date AS DATE) AS date_evenement,
    
    -- Nettoyage du TYPE d'événement
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
    ) AS type_evenement,
    
    TRIM(mois) AS mois_evenement,
    CAST(impact_moral AS INT64) AS impact_moral,
    
    -- Nettoyage des DEPARTEMENTS CONCERNÉS
    TRIM(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(departements_concernes, 'Ã©', 'é'),
                    'Ã¨', 'è'
                ),
                'Ã ', 'à'
            ),
            'â‚¬', '€'    -- Correction du symbole Euro
        )
    ) AS departements_concernes
    
FROM {{ source('company_metadata','evenements_entreprise') }}
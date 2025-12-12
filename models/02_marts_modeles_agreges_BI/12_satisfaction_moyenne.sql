{{ config(
    materialized='table', 
    schema='peoplepulse', 
    alias='12_satisfaction_moyenne'
) }}

SELECT
      employee_id,
      Round((
          sentiment_global +
          satisfaction_equipe +
          satisfaction_manager +
          culture_entreprise +
          equilibre_vie_pro_perso +
          opportunites_carriere +
          reconnaissance
      ) / 7.0,2) AS satisfaction_moyenne,
      date_enquete,
      mois_depuis_derniere_promo,
      jours_absents_12mois
FROM {{ ref('00_Table_individus') }}

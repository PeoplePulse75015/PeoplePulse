SELECT
    TRIM(employee_id) AS employee_id,
    CAST(sentiment_global AS FLOAT64) AS sentiment_global,
    CAST(satisfaction_equipe AS FLOAT64) AS satisfaction_equipe,
    CAST(satisfaction_manager AS FLOAT64) AS satisfaction_manager,
    CAST(culture_entreprise AS FLOAT64) AS culture_entreprise,
    CAST(equilibre_vie_pro_perso AS FLOAT64) AS equilibre_vie_pro_perso,
    CAST(opportunites_carriere AS FLOAT64) AS opportunites_carriere,
    CAST(reconnaissance AS FLOAT64) AS reconnaissance,
    CAST(nps_employeur AS INT64) AS nps_employeur, 
    CAST(date_enquete AS DATE) AS date_enquete
FROM {{ source('peoplepulse_data','enquetes_satisfaction') }}
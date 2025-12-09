SELECT
    TRIM(employee_id) AS employee_id,
    CAST(sentiment_global AS FLOAT) AS sentiment_global,
    CAST(satisfaction_equipe AS FLOAT) AS satisfaction_equipe,
    CAST(satisfaction_manager AS FLOAT) AS satisfaction_manager,
    CAST(culture_entreprise AS FLOAT) AS culture_entreprise,
    CAST(equilibre_vie_pro_perso AS FLOAT) AS equilibre_vie_pro_perso,
    CAST(opportunites_carriere AS FLOAT) AS opportunites_carriere,
    CAST(reconnaissance AS FLOAT) AS reconnaissance,
    CAST(nps_employeur AS INT) AS nps_employeur, 
    CAST(date_enquete AS DATE) AS date_enquete
FROM {{ source('individus','enquete_satisfaction') }}
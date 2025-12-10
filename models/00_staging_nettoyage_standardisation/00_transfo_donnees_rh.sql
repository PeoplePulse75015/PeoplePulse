SELECT
    TRIM(employee_id) AS employee_id,
    CAST(age AS INT64) AS age,
    TRIM(departement) AS departement,
    TRIM(poste) AS poste,
    TRIM(niveau) AS niveau,
    CAST(anciennete_annees AS FLOAT64) AS anciennete_annees,
    CAST(salaire_annuel AS INT64) AS salaire_annuel,
    CAST(performance AS FLOAT64) AS performance,
    CASE
        WHEN est_parti IN ('1') THEN TRUE
        WHEN est_parti IN ('0') THEN FALSE
        ELSE NULL
    END AS est_parti,
    TRIM(statut) AS statut,
    CAST(date_depart AS DATE) AS date_depart,
    CAST(mois_depart AS STRING) AS mois_depart
FROM {{ source('peoplepulse_data','donnees_rh') }}
ORDER BY employee_id 


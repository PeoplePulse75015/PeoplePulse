-- Table donnees rh
SELECT
    TRIM(employee_id) AS employee_id,
    CAST(age AS INT) AS age,
    TRIM(departement) AS departement,
    TRIM(poste) AS poste,
    TRIM(niveau) AS niveau,
    CAST(anciennete_annees AS FLOAT) AS anciennete_annees,
    CAST(salaire_annuel AS INT) AS salaire_annuel,
    CAST(performance AS FLOAT) AS performance,
    CAST(est_parti AS BOOLEAN) AS est_parti,
    TRIM(statut) AS statut,
    CAST(date_depart AS DATE) AS date_depart,
    CAST(mois_depart AS STRING) AS mois_depart,
FROM {{ source('individus','donnees_rh') }}


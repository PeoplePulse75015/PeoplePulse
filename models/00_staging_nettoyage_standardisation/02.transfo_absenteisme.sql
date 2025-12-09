SELECT
    TRIM(employee_id) AS employee_id,
    CAST(jours_absents_12mois AS INT) AS jours_absents_12mois,
    CAST(frequence_absences AS INT) AS frequence_absences,
    CAST(taux_absenteisme AS FLOAT) AS taux_absenteisme,
    TRIM(motif_principal) AS motif_principal,
    CAST(absences_longue_duree AS BOOLEAN) AS absences_longue_duree
FROM {{ source('individus','absenteisme') }}
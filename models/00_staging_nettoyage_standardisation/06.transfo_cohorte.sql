SELECT
    TRIM(mois_embauche) AS mois_embauche,
    CAST(annee_embauche AS INT) AS annee_embauche,
    TRIM(trimestre_embauche) AS trimestre_embauche,
    TRIM(periode_embauche) AS periode_embauche,
    CAST(nb_embauches AS INT) AS nb_embauches,
    CAST(retention_6mois AS FLOAT) AS retention_6mois,
    CAST(retention_12mois AS FLOAT) AS retention_12mois,
    CAST(retention_24mois AS FLOAT) AS retention_24mois
FROM {{ source('entreprise','cohorte_embauche') }}
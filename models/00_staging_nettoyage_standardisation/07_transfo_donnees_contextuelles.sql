SELECT
    TRIM(mois) AS mois_contexte,
    TRIM(trimestre_x) AS trimestre_x,
    TRIM(trimestre_y) AS trimestre_y,
    CAST(taux_chomage AS FLOAT64) AS taux_chomage,
    CAST(croissance_pib_trim AS FLOAT64) AS croissance_pib_trim,
    CAST(indice_confiance AS FLOAT64) AS indice_confiance,
    CAST(inflation AS FLOAT64) AS inflation,
    CAST(nb_offres_it AS INT64) AS nb_offres_it,
    CAST(salaire_median_it AS INT64) AS salaire_median_it,
    CAST(demande_competences_rares AS FLOAT64) AS demande_competences_rares,
    CAST(tension_recrutement AS FLOAT64) AS tension_recrutement,
    CAST(nb_concurrents_actifs AS INT64) AS nb_concurrents_actifs,
    CAST(ecart_salarial_marche AS FLOAT64) AS ecart_salarial_marche,
    CAST(attractivite_relative AS FLOAT64) AS attractivite_relative,
    CAST(activite_chasseurs_tetes AS FLOAT64) AS activite_chasseurs_tetes,
    CASE
        WHEN periode_recrutement_forte IN ('1') THEN TRUE
        WHEN periode_recrutement_forte IN ('0') THEN FALSE
        ELSE NULL
    END AS periode_recrutement_forte,
    CASE
        WHEN periode_evaluations IN ('1') THEN TRUE
        WHEN periode_evaluations IN ('0') THEN FALSE
        ELSE NULL
    END AS periode_evaluations,
    CASE
        WHEN periode_promotions IN ('1') THEN TRUE
        WHEN periode_promotions IN ('0') THEN FALSE
        ELSE NULL
    END AS periode_promotions,
    CASE
        WHEN periode_recrutement IN ('1') THEN TRUE
        WHEN periode_recrutement IN ('0') THEN FALSE
        ELSE NULL
    END AS periode_recrutement,
    CASE
        WHEN periode_departs_eleves IN ('1') THEN TRUE
        WHEN periode_departs_eleves IN ('0') THEN FALSE
        ELSE NULL
    END AS periode_departs_eleves
FROM {{ source('company_metadata','donnees_contextuelles') }}
SELECT
    TRIM(employee_id) AS employee_id,
    CAST(nb_promotions AS INT64) AS nb_promotions,
    CAST(nb_mobilites_internes AS INT64) AS nb_mobilites_internes,
    CAST(mois_depuis_derniere_promo AS INT64) AS mois_depuis_derniere_promo,
    CAST(progression_salariale_pct AS FLOAT64) AS progression_salariale_pct, 
    CAST(nb_formations_suivies AS INT64) AS nb_formations_suivies,
    CASE
        WHEN stagnation_detectee IN (1) THEN TRUE
        WHEN stagnation_detectee IN (0) THEN FALSE
        ELSE NULL
    END AS stagnation_detectee,
    CASE
        WHEN changement_manager_12mois IN (1) THEN TRUE
        WHEN changement_manager_12mois IN (0) THEN FALSE
        ELSE NULL
    END AS changement_manager_12mois,
    CASE
        WHEN demande_mutation_refusee IN (1) THEN TRUE
        WHEN demande_mutation_refusee IN (0) THEN FALSE
        ELSE NULL
    END AS demande_mutation_refusee,
    CASE
        WHEN potentiel_identifie IN (1) THEN TRUE
        WHEN potentiel_identifie IN (0) THEN FALSE
        ELSE NULL
    END AS potentiel_identifie
FROM {{ source('peoplepulse_data','historique_carriere') }}
ORDER BY employee_id
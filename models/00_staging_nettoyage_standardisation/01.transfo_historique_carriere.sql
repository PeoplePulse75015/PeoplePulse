SELECT
    TRIM(employee_id) AS employee_id,
    CAST(nb_promotions AS INT) AS nb_promotions,
    CAST(nb_mobilites_internes AS INT) AS nb_mobilites_internes,
    CAST(mois_depuis_derniere_promo AS INT) AS mois_depuis_derniere_promo,
    CAST(progression_salariale_pct AS FLOAT) AS progression_salariale_pct, 
    CAST(nb_formations_suivies AS INT) AS nb_formations_suivies,
    CAST(stagnation_detectee AS BOOLEAN) AS stagnation_detectee,
    CAST(changement_manager_12mois AS BOOLEAN) AS changement_manager_12mois,
    CAST(demande_mutation_refusee AS BOOLEAN) AS demande_mutation_refusee,
    CAST(potentiel_identifie AS BOOLEAN) AS potentiel_identifie
FROM {{ source('individus','historique_carriere') }}
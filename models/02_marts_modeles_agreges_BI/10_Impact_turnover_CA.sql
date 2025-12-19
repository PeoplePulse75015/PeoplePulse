WITH calculs_intermediaires AS (
    SELECT
        mois_reference,
        ca_moyen_employe_annuel,
        effectif,
        cout_recrutement_total,
        cout_formation_total,
        cout_indirect_total,
        cout_total_mensuel,
        
        -- Calculs intermédiaires (maintenant disponibles pour la SELECT finale)
        (ca_moyen_employe_annuel * effectif) AS CA_mensuel_calcule
    FROM 
        {{ ref('02_Join_table_historique_contexte') }}
)

SELECT
    mois_reference,
    CA_mensuel_calcule, -- Le CA mensuel est maintenant une colonne disponible
    effectif,
    cout_recrutement_total,
    ROUND((cout_recrutement_total / cout_total_mensuel) * 100,2) AS recrutement_sur_couts_mensuels,

    cout_formation_total,
    ROUND((cout_formation_total / cout_total_mensuel) * 100,2) AS formations_sur_couts_mensuels,

    cout_indirect_total,
    ROUND((cout_indirect_total / cout_total_mensuel) * 100,2) AS indirect_sur_couts_mensuels,

    cout_total_mensuel, 
    
    (CA_mensuel_calcule - cout_total_mensuel) AS CA_dispo_apres_couts_turnover, 
    ROUND((cout_total_mensuel / CA_mensuel_calcule) * 100,2) AS part_couts_sur_CA 

FROM calculs_intermediaires
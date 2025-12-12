SELECT
    departement,
    niveau_hierarchie,
    ROUND(AVG(sentiment_global), 2) AS avg_sentiment_global,
    ROUND(AVG(satisfaction_equipe), 2) AS avg_satisfaction_equipe,
    ROUND(AVG(satisfaction_manager), 2) AS avg_satisfaction_manager,
    ROUND(AVG(culture_entreprise), 2) AS avg_culture_entreprise,
    ROUND(AVG(equilibre_vie_pro_perso), 2) AS avg_equilibre_vie_pro_perso,
    ROUND(AVG(opportunites_carriere), 2) AS avg_opportunites_carriere,
    ROUND(AVG(reconnaissance), 2) AS avg_reconnaissance,
    ROUND(AVG(nps_employeur), 2) AS avg_nps_employeur
FROM {{ ref('00_Table_individus') }}
GROUP BY
    departement,
    niveau_hierarchie
ORDER BY
    departement,
    niveau_hierarchie ASC
{{ config(
    materialized='view',
    tags=['analysis', 'general']
) }}

WITH source_data AS (
    SELECT
        est_parti,
        age,
        anciennete_annees,
        salaire_annuel,
        salaire_median_departement,
        salaire_median_departement_niveau,
        salaire_moyen_departement,
        salaire_moyen_departement_niveau,
        performance,
        niveau_hierarchie,
        nb_promotions,
        nb_mobilites_internes,
        mois_depuis_derniere_promo,
        progression_salariale_pct,
        nb_formations_suivies,
        jours_absents_12mois,
        taux_absenteisme,
        sentiment_global,
        satisfaction_equipe,
        satisfaction_manager,
        culture_entreprise,
        equilibre_vie_pro_perso,
        opportunites_carriere,
        reconnaissance,
        nps_employeur,
        feedback_collegues,
        feedback_managers,
        cohesion_equipe,
        competences_techniques,
        soft_skills,
        leadership,
        communication,
        nb_feedbacks_recus
    FROM 
        {{ ref('00_Table_individus') }}
)

SELECT
    CASE
        WHEN est_parti THEN 'Parti'
        ELSE 'Resté'
    END AS statut_employe,
    
    COUNT(*) AS total_employes,
    
    -- Statistiques arrondies à 2 décimales
    ROUND(AVG(age), 2) AS moyenne_age,
    ROUND(AVG(anciennete_annees), 2) AS moyenne_anciennete_annees,
    ROUND(AVG(salaire_annuel), 2) AS moyenne_salaire_annuel,
    ROUND(AVG(salaire_median_departement), 2) AS moyenne_salaire_median_departement,
    ROUND(AVG(salaire_median_departement_niveau), 2) AS moyenne_salaire_median_departement_niveau,
    ROUND(AVG(salaire_moyen_departement), 2) AS moyenne_salaire_moyen_departement,
    ROUND(AVG(salaire_moyen_departement_niveau), 2) AS moyenne_salaire_moyen_departement_niveau,
    ROUND(AVG(performance), 2) AS moyenne_performance,
    ROUND(AVG(niveau_hierarchie), 2) AS moyenne_niveau_hierarchie,
    ROUND(AVG(nb_promotions), 2) AS moyenne_nb_promotions,
    ROUND(AVG(nb_mobilites_internes), 2) AS moyenne_nb_mobilites_internes,
    ROUND(AVG(mois_depuis_derniere_promo), 2) AS moyenne_mois_depuis_derniere_promo,
    ROUND(AVG(progression_salariale_pct), 2) AS moyenne_progression_salariale_pct,
    ROUND(AVG(nb_formations_suivies), 2) AS moyenne_nb_formations_suivies,
    ROUND(AVG(jours_absents_12mois), 2) AS moyenne_jours_absents_12mois,
    ROUND(AVG(taux_absenteisme), 2) AS moyenne_taux_absenteisme,
    ROUND(AVG(sentiment_global), 2) AS moyenne_sentiment_global,
    ROUND(AVG(satisfaction_equipe), 2) AS moyenne_satisfaction_equipe,
    ROUND(AVG(satisfaction_manager), 2) AS moyenne_satisfaction_manager,
    ROUND(AVG(culture_entreprise), 2) AS moyenne_culture_entreprise,
    ROUND(AVG(equilibre_vie_pro_perso), 2) AS moyenne_equilibre_vie_pro_perso,
    ROUND(AVG(opportunites_carriere), 2) AS moyenne_opportunites_carriere,
    ROUND(AVG(reconnaissance), 2) AS moyenne_reconnaissance,
    ROUND(AVG(nps_employeur), 2) AS moyenne_nps_employeur,
    ROUND(AVG(feedback_collegues), 2) AS moyenne_feedback_collegues,
    ROUND(AVG(feedback_managers), 2) AS moyenne_feedback_managers,
    ROUND(AVG(cohesion_equipe), 2) AS moyenne_cohesion_equipe,
    ROUND(AVG(competences_techniques), 2) AS moyenne_competences_techniques,
    ROUND(AVG(soft_skills), 2) AS moyenne_soft_skills,
    ROUND(AVG(leadership), 2) AS moyenne_leadership,
    ROUND(AVG(communication), 2) AS moyenne_communication,
    ROUND(AVG(nb_feedbacks_recus), 2) AS moyenne_nb_feedbacks_recus
    
FROM
    source_data
GROUP BY 1
ORDER BY 1
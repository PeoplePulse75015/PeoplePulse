SELECT
    employee_id,
    satisfaction_moyenne,
    date_enquete,
    mois_depuis_derniere_promo,
    jours_absents_12mois,
    nps_employeur,
    feedback_collegues,
    feedback_managers
FROM 
    {{ ref('12_satisfaction_moyenne') }}
WHERE 
    satisfaction_moyenne BETWEEN 2.5 AND 3     
    AND mois_depuis_derniere_promo >= 12
    AND jours_absents_12mois >= 14
    AND nps_employeur <=8
    AND est_parti = FALSE

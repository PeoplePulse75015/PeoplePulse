SELECT
    employee_id,
    satisfaction_moyenne,
    date_enquete,
    mois_depuis_derniere_promo,
    jours_absents_12mois
FROM 
    {{ ref('12_satisfaction_moyenne') }}
WHERE 
    satisfaction_moyenne < 2.5          
    AND mois_depuis_derniere_promo > 12
    AND jours_absents_12mois > 20
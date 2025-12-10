SELECT
    TRIM(employee_id) AS employee_id,
    CAST(feedback_collegues AS FLOAT64) AS feedback_collegues,
    CAST(feedback_managers AS FLOAT64) AS feedback_managers,
    CAST(cohesion_equipe AS FLOAT64) AS cohesion_equipe,
    CAST(competences_techniques AS FLOAT64) AS competences_techniques,
    CAST(soft_skills AS FLOAT64) AS soft_skills,
    CAST(leadership AS FLOAT64) AS leadership,
    CAST(communication AS FLOAT64) AS communication,
    CAST(nb_feedbacks_recus AS INT64) AS nb_feedbacks_recus,
    CAST(date_evaluation AS DATE) AS date_evaluation
FROM {{ source('peoplepulse_data','feedback_360') }}
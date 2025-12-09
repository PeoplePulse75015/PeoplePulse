SELECT
    TRIM(employee_id) AS employee_id,
    CAST(feedback_collegues AS FLOAT) AS feedback_collegues,
    CAST(feedback_managers AS FLOAT) AS feedback_managers,
    CAST(cohesion_equipe AS FLOAT) AS cohesion_equipe,
    CAST(competences_techniques AS FLOAT) AS competences_techniques,
    CAST(soft_skills AS FLOAT) AS soft_skills,
    CAST(leadership AS FLOAT) AS leadership,
    CAST(communication AS FLOAT) AS communication,
    CAST(nb_feedbacks_recus AS INT) AS nb_feedbacks_recus,
    CAST(date_evaluation AS DATE) AS date_evaluation
FROM {{ source('individus','feedback_360') }}
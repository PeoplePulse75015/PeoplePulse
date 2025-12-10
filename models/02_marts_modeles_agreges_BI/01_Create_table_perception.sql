
{{ config(
    materialized='table',
    schema='individus',
    alias='perception_agg'
) }}

SELECT
 t03.employee_id,
 t03.sentiment_global,
 t03.satisfaction_equipe,
 t03.satisfaction_manager,
 t03.culture_entreprise,
 t03.equilibre_vie_pro_perso,
 t03.opportunites_carriere,
 t03.reconnaissance,
 t03.nps_employeur, 
 t03.date_enquete,
 t04.feedback_collegues,
 t04.feedback_managers,
 t04.cohesion_equipe,
 t04.competences_techniques,
 t04.soft_skills,
 t04.leadership,
 t04.communication,
 t04.nb_feedbacks_recus,
 t04.date_evaluation
FROM {{ ref('03_transfo_enquete_satisfaction') }} AS t03
INNER JOIN {{ ref('04_transfo_feedback360') }} AS t04 ON t03.employee_id = t04.employee_id
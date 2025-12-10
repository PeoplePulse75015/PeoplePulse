-- Solution visuelle pour BigQuery afin de vérifier qu'il n'y a pas de doublons sur ce qui est considéré comme clé primaire
-- Code pour chaque table transformée, pour vérifier si la clef primaire est répétée, donc >1
-- Code qui renforce le contrôle mis dans source et schéma pour le test "unique"

WITH
    cte_00_transfo_donnees_rh_violations AS (
        SELECT          -- --> requête pour mettre en forme le résultat : titre | nombre_doublons 
            '00.transfo_donnees_rh' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (          -- --> Sous requête pour compter par clef primaire le nombre de fois où il apparaît plus d'1 fois 
            SELECT
                employee_id
            FROM {{ source('peoplepulse_data','donnees_rh') }}
            GROUP BY 1
            HAVING COUNT(*) > 1 -- Doublons si la clé primaire apparaît plus d'1 fois
        ) AS duplicates_agg
    ),
    
    cte_01_transfo_historique_carriere_violations AS (
        SELECT
            '01.transfo_historique_carriere' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                employee_id
            FROM {{ source('peoplepulse_data','historique_carriere') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_02_transfo_absenteisme_violations AS (
        SELECT
            '02.transfo_absenteisme' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                employee_id
            FROM {{ source('peoplepulse_data','absenteisme') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    -- Modèles avec Clé Primaire Composée (employee_id + date)
    cte_03_transfo_enquete_satisfaction_violations AS (
        SELECT
            '03.transfo_enquete_satisfaction' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                employee_id, date_enquete
            FROM {{ source('peoplepulse_data','enquetes_satisfaction') }}
            GROUP BY 1, 2
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_04_transfo_feedback360_violations AS (
        SELECT
            '04.transfo_feedback360' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                employee_id, date_evaluation
            FROM {{ source('peoplepulse_data','feedback_360') }}
            GROUP BY 1, 2
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    -- Modèles avec Clé Primaire basée sur le Temps (mois/date)
    cte_05_transfo_histo_mensuel_20_24_violations AS (
        SELECT
            '05.transfo_histo_mensuel_20_24' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                mois
            FROM {{ source('company_metadata','historique_mensuel_2020_2024') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_06_transfo_cohorte_violations AS (
        SELECT
            '06.transfo_cohorte' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                mois_embauche
            FROM {{ source('company_metadata','cohortes_embauche') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_07_transfo_donnees_contextuelles_violations AS (
        SELECT
            '07.transfo_donnees_contextuelles' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                mois
            FROM {{ source('company_metadata','donnees_contextuelles') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_08_transfo_evenements_entreprise_violations AS (
        SELECT
            '08_transfo_evenements_entreprise' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                date
            FROM {{ source('company_metadata','evenements_entreprise') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    ),
    
    cte_09_transfo_evenements_historiques_violations AS (
        SELECT
            '09.transfo_evenements_historiques' AS table_name,
            COUNT(*) AS nombre_doublons
        FROM (
            SELECT
                date
            FROM {{ source('company_metadata','evenements_historiques_2020_2024') }}
            GROUP BY 1
            HAVING COUNT(*) > 1
        ) AS duplicates_agg
    )


-- Une fois toutes ces opérations faite, "union" des résultats pour faire un tableau global


SELECT * FROM cte_00_transfo_donnees_rh_violations
UNION ALL
SELECT * FROM cte_01_transfo_historique_carriere_violations
UNION ALL
SELECT * FROM cte_02_transfo_absenteisme_violations
UNION ALL
SELECT * FROM cte_03_transfo_enquete_satisfaction_violations
UNION ALL
SELECT * FROM cte_04_transfo_feedback360_violations
UNION ALL
SELECT * FROM cte_05_transfo_histo_mensuel_20_24_violations
UNION ALL
SELECT * FROM cte_06_transfo_cohorte_violations
UNION ALL
SELECT * FROM cte_07_transfo_donnees_contextuelles_violations
UNION ALL
SELECT * FROM cte_08_transfo_evenements_entreprise_violations
UNION ALL
SELECT * FROM cte_09_transfo_evenements_historiques_violations
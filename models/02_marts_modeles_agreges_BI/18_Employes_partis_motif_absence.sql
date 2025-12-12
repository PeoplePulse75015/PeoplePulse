WITH Scores_et_Frequence AS ( 
    SELECT
        departement,
        niveau,
        motif_principal,
        
        -- 1. Calcul de la moyenne des jours absents pour chaque combinaison (Département, Niveau, Motif)
        ROUND(AVG(jours_absents_12mois), 2) AS moyenne_jours_absents,
        
        -- 2. Compte de la fréquence de ce motif dans ce groupe (Département, Niveau, Motif)
        COUNT(*) AS nb_occurrences_motif
    FROM 
        {{ ref("00_Table_individus")}}
    WHERE 
        est_parti = TRUE
    GROUP BY 
        departement,
        niveau,
        motif_principal
), 

Motif_Le_Plus_Frequent AS ( 
    SELECT
        departement,
        niveau,
        moyenne_jours_absents,
        motif_principal,
        nb_occurrences_motif,
        
        -- Classement par nombre d'occurrences (fréquence) pour chaque (Département, Niveau)
        ROW_NUMBER() OVER(
            PARTITION BY departement, niveau 
            ORDER BY nb_occurrences_motif DESC, motif_principal ASC 
        ) AS rang_motif_frequent
    FROM Scores_et_Frequence
)

SELECT
    departement,
    niveau,
    moyenne_jours_absents,
    motif_principal AS motif_principal_du_groupe
FROM Motif_Le_Plus_Frequent
WHERE rang_motif_frequent = 1
ORDER BY departement, niveau
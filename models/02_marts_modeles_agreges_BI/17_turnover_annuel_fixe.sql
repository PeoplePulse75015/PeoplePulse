WITH annual AS (
  SELECT
    annee,
    SUM(nb_departs) AS total_departs,
    SUM(nb_embauches) AS total_embauches,

    -- On arrondit ici → effectif moyen en entier
    ROUND(AVG(effectif)) AS effectif_moyen_annuel
  FROM {{ ref('01_Table_Historique_Contexte') }}
  GROUP BY annee
)
SELECT
  annee,
  total_departs,
  total_embauches,
  effectif_moyen_annuel,

  ROUND(
    SAFE_DIVIDE(total_departs, effectif_moyen_annuel) * 100,
    2
  ) AS taux_turnover_fixe_annuel

FROM annual
ORDER BY annee
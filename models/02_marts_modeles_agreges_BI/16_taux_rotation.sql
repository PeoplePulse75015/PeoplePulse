SELECT
  departement,
  niveau,
  COUNTIF(est_parti) AS nb_depart,
  COUNT(*) AS nb_total,
  
  -- La formule : (Départs / Total) * 100, arrondi à 2 décimales
  ROUND(
    (CAST(COUNTIF(est_parti) AS FLOAT64) / COUNT(*)) * 100
  , 2) AS taux_rotation_pourcentage
  
FROM
  {{ ref('00_Table_individus') }}
GROUP BY
  1, 2
HAVING
  COUNT(*) >= 10 -- Filtre les groupes avec au moins 10 employés pour une statistique plus fiable
ORDER BY
  taux_rotation_pourcentage DESC
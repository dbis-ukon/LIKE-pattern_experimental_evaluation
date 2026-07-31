WITH top_studios AS (
  SELECT cn.id
  FROM company_name cn
  JOIN movie_companies mc ON cn.id = mc.company_id
  JOIN title t ON mc.movie_id = t.id
  WHERE cn.name LIKE 'Pou%i _a%u_ court?'
    AND cn.country_code = '[us]'
    AND t.title NOT LIKE 'Cua_r%e_t%v_st%'
    AND mc.company_type_id IN (2, 1)
    AND mc.note IS NULL
    AND t.kind_id IN (1, 3, 7, 6)
    AND t.episode_of_id IS NULL
  GROUP BY cn.id
  ORDER BY COUNT(DISTINCT mc.movie_id) DESC
  LIMIT 10
)
SELECT cn.country_code,
       COUNT(DISTINCT t.id) AS total_titles,
       COUNT(DISTINCT CASE WHEN mc.company_id IN (SELECT id FROM top_studios)
                           THEN t.id END) AS top_studio_titles
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN company_name cn ON mc.company_id = cn.id
WHERE t.title LIKE 'Punch Up 2'
  AND k.keyword LIKE '%k%-o%'
  AND cn.name LIKE '_s%c_ Fi_m_'
  AND mc.note IS NULL
  AND mc.company_type_id IN (1, 2)
  AND t.kind_id IN (7, 1, 2)
  AND cn.country_code IS NOT NULL
  AND k.phonetic_code IS NOT NULL
GROUP BY cn.country_code
ORDER BY total_titles DESC;

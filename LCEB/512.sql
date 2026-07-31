SELECT
    t.title,
    n.name,
    COUNT(DISTINCT akat.title) AS alt_titles
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Le m_rage'
  AND akat.title LIKE 'T_O_C_'
  AND n.name LIKE 'M_Mahan'
  AND k.keyword LIKE 'gre_k-militar_'
  AND t.production_year BETWEEN 1971 AND 2000
GROUP BY t.title, n.name
HAVING COUNT(DISTINCT akat.title) > 1;

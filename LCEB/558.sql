SELECT
    t.title,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT k.id) AS keyword_count
FROM title t
JOIN cast_info ci       ON t.id = ci.movie_id
JOIN name n             ON ci.person_id = n.id
JOIN aka_title akat       ON t.id = akat.movie_id
JOIN movie_keyword mk   ON t.id = mk.movie_id
JOIN keyword k          ON mk.keyword_id = k.id
WHERE t.production_year >= 1912
  AND ci.nr_order <= 2
  AND n.name LIKE 'Re%'
  AND akat.title LIKE 'Der_l%e%e Medi_ine_'
  AND k.keyword LIKE '_oat_y%d'
  AND t.title LIKE '_20%-%-_6)'
GROUP BY t.title
ORDER BY cast_count DESC;

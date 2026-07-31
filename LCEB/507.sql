SELECT
    t.title,
    t2.title AS linked_title,
    lt.link,
    COUNT(DISTINCT k.keyword) AS kw_count
FROM title t
JOIN movie_link ml ON t.id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN title t2 ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Bri_ish Le_b%n Amateurs 1'
  AND t2.title LIKE 'N%r_l%edic%e'
  AND lt.link LIKE '%sequel%'
  AND k.keyword LIKE '_p%la_s'
  AND t.production_year BETWEEN 1974 AND 2011
GROUP BY t.title, t2.title, lt.link
HAVING COUNT(DISTINCT k.keyword) >= 1;

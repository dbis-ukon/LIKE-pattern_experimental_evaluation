SELECT mi.info AS genre, AVG(CAST(mii.info AS NUMERIC)) AS avg_rating,
       COUNT(DISTINCT t.id) AS n_titles
FROM title t
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it1 ON mi.info_type_id = it1.id
JOIN movie_info_idx mii ON t.id = mii.movie_id
JOIN info_type it2 ON mii.info_type_id = it2.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
WHERE it1.info = 'LD disc format'
  AND it2.info = 'LD close captions-teletext-ld-g'
  AND mii.info ~ '^[0-9.]+$'
  AND t.title LIKE '_o_se_:%ents'
  AND k.keyword LIKE 'mod_rn-mexico'
  AND cn.name LIKE 'B_ack Tuesda%Films'
  AND cn.country_code IN ('[it]', '[jp]', '[ca]', '[is]', '[us]')
  AND mc.note IS NULL
  AND mc.company_type_id IN (2, 1)
  AND t.kind_id IN (1, 7, 3, 2, 6)
  AND k.phonetic_code IS NOT NULL
GROUP BY mi.info
HAVING COUNT(DISTINCT t.id) >= 5
ORDER BY avg_rating DESC;

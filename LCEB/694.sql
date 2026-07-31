SELECT k2.keyword, COUNT(DISTINCT t.id) AS co_occurrences
FROM keyword k1
JOIN movie_keyword mk1 ON k1.id = mk1.keyword_id
JOIN movie_keyword mk2 ON mk1.movie_id = mk2.movie_id
                       AND mk1.keyword_id <> mk2.keyword_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
JOIN title t ON mk1.movie_id = t.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
WHERE k1.keyword LIKE 'referen_e_t%a%-%e_s%e_m%l'
  AND k2.keyword NOT LIKE 'king-costume'
  AND t.title NOT LIKE '(_1.101_8)'
  AND cn.name LIKE 'BSI'
  AND cn.country_code = '[us]'
  AND mc.note IS NULL
  AND mc.company_type_id IN (2, 1)
  AND t.kind_id IN (7, 1, 2)
  AND t.episode_of_id IS NULL
  AND k1.phonetic_code IS NOT NULL
  AND k2.phonetic_code IS NOT NULL
GROUP BY k2.keyword
HAVING COUNT(DISTINCT t.id) >= 2
ORDER BY co_occurrences DESC
LIMIT 20;

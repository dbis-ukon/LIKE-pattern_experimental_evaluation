SELECT akat.movie_id, t.title, c.name AS company_name, COUNT(DISTINCT k.keyword) AS keyword_count
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE c.country_code = '[fi]'
  AND n.gender = 'f'
  AND (n.name LIKE 'Wilba_ks' OR n.name LIKE 'T%t% J_s_')
  AND (t.title LIKE '_i%y''s Secret' OR t.title LIKE '_ _unk_of H_rd_ar_')
GROUP BY akat.movie_id, t.title, c.name
ORDER BY keyword_count DESC;

SELECT cn.country_code, COUNT(DISTINCT t.id) AS n_titles, COUNT(DISTINCT cn.id) AS n_studios
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE t.title LIKE 'Australiens Süden'
  AND cn.name LIKE '_i%nt%v_es'
  AND k.keyword LIKE 'miss%ar_e_-o_-cha%ty'
  AND akat.title LIKE '%o_y_Sp_l%C_u%ge'
  AND cn.country_code IN ('[fi]', '[de]', '[us]', '[be]', '[in]')
  AND mc.note IS NULL
  AND mc.company_type_id = 2
  AND t.kind_id IN (1, 7)
  AND t.episode_of_id IS NULL
  AND akat.md5sum IS NOT NULL
GROUP BY cn.country_code
ORDER BY n_titles DESC;

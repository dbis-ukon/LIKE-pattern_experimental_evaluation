SELECT n.id, n.name, COUNT(DISTINCT t.id) AS lead_roles
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN aka_title akat ON t.id = akat.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE 'G_ldman'
  AND t.title NOT LIKE 'S% Sp%n% %k'
  AND akat.title LIKE 'Höllenjag_'
  AND cn.name LIKE '_e%P%n_'
  AND k.keyword LIKE '%r_o%c%'
  AND ci.nr_order <= 1
  AND ci.nr_order IS NOT NULL
  AND n.gender = 'f'
  AND ci.role_id IN (8, 7, 1, 6, 10)
  AND t.kind_id IN (3, 7, 2, 1)
  AND t.episode_of_id IS NULL
  AND n.name_pcode_nf IS NOT NULL
  AND akat.md5sum IS NOT NULL
GROUP BY n.id, n.name
HAVING COUNT(DISTINCT t.id) >= 3
ORDER BY lead_roles DESC
LIMIT 50;

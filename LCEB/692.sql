SELECT cn1.name AS company_a, cn2.name AS company_b,
       COUNT(DISTINCT t.id) AS shared_titles
FROM movie_companies mc1
JOIN movie_companies mc2 ON mc1.movie_id = mc2.movie_id
                         AND mc1.company_id < mc2.company_id
JOIN company_name cn1 ON mc1.company_id = cn1.id
JOIN company_name cn2 ON mc2.company_id = cn2.id
JOIN title t ON mc1.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE cn1.name LIKE 'Joe Films Productions'
  AND cn2.name LIKE 'Desh%Zohar-Topol Produ_t_ons'
  AND t.title NOT LIKE '_a%d%qu_ no_ces%'
  AND k.keyword LIKE '%r%t_r%-%'
  AND akat.title LIKE '%e%o%n_s Tro_b% % W_me_'
  AND cn1.country_code = '[us]'
  AND cn2.country_code IN ('[tw]', '[nl]', '[gb]', '[es]', '[au]')
  AND mc1.company_type_id IN (2, 1)
  AND mc2.company_type_id IN (1, 2)
  AND mc1.note IS NULL
  AND mc2.note IS NULL
  AND t.kind_id IN (1, 2, 6, 7, 3)
  AND akat.md5sum IS NOT NULL
GROUP BY cn1.name, cn2.name
HAVING COUNT(DISTINCT t.id) >= 2
ORDER BY shared_titles DESC
LIMIT 25;

SELECT
    co.name AS company_name,
    k.keyword AS movie_keyword,
    COUNT(DISTINCT c.id) AS num_characters,
    MIN(a.production_year) AS first_year,
    MAX(a.production_year) AS last_year,
    AVG(ca.nr_order) AS avg_cast_order
FROM movie_companies mc
JOIN company_name co ON mc.company_id = co.id
JOIN aka_title a ON mc.movie_id = a.movie_id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ca ON a.movie_id = ca.movie_id
JOIN char_name c ON ca.person_id = c.id
JOIN title t ON a.movie_id = t.id
JOIN complete_cast cc ON a.id = cc.movie_id
JOIN name n ON cc.subject_id = n.id
WHERE a.title LIKE 'K_m%z_ Ok_n_wa_Ze_o'
  AND t.title LIKE 'O_Trab_l%d_s_H%ens'
  AND c.name LIKE '_go_ %ska'
  AND co.name LIKE '%n%e%a%m%'
  AND k.keyword LIKE 'd_c%ap'
  AND n.name LIKE 'Ashley'
  AND ca.nr_order < 5
  AND t.season_nr = 1
  AND co.country_code = '[au]'
GROUP BY co.name, k.keyword
ORDER BY num_characters DESC;

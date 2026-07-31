SELECT a.title AS aka_title, t.title AS movie_title, c.name AS character_name, co.name AS company_name, k.keyword AS movie_keyword, n.name AS person_name, MIN(a.production_year) AS min_year, MAX(a.production_year) AS max_year, COUNT(DISTINCT ca.person_id) AS num_cast
FROM aka_title a
JOIN cast_info ca ON a.movie_id = ca.movie_id
JOIN char_name c ON ca.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN complete_cast cc ON a.id = cc.movie_id
JOIN name n ON cc.subject_id = n.id
JOIN title t ON a.movie_id = t.id
WHERE a.title LIKE '%thi%M%e %sy'
  AND t.title LIKE 'A_n_ D%h_an'
  AND c.name LIKE '%li_ _l_iborne'
  AND co.name LIKE 'Jacques _escen_ _roductions'
  AND k.keyword LIKE 'y%p%d%'
  AND n.name LIKE '%a% _a_r_'
  AND a.production_year BETWEEN 1929 AND 1994
  AND ca.nr_order > 4
  AND co.country_code = '[de]'
GROUP BY a.title, t.title, c.name, co.name, k.keyword, n.name
ORDER BY max_year DESC;

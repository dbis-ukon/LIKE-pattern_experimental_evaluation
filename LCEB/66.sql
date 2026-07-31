SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name,
       k.keyword AS keyword,
       mi.info AS movie_info
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE 'S_a%a%on%'
  AND cn.name LIKE 'Pa_l%arr_'
  AND akat.title LIKE 'Mar_ Twains Abenteuer'
  AND n.name LIKE 'Satou'
  AND k.keyword LIKE '%r%f-%a_'
  AND c.name LIKE '%r%en_'
  AND ct.kind = 'distributors'
  AND mi.info LIKE '%budget%'
  AND ci.nr_order <= 19
  AND akat.season_nr BETWEEN 1 AND 1
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword, mi.info
ORDER BY num_movies DESC;

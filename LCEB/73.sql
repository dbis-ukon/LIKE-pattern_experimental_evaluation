SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name,
       k.keyword AS keyword,
       mi.info AS movie_info,
       lt.link AS link_type
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE 'Nick Babbo'
  AND cn.name LIKE '%l_M%n%a'
  AND akat.title LIKE 'Der R_igen'
  AND n.name LIKE '%ce%u_ie'
  AND k.keyword LIKE 'self_d_agnosi_-o_-ill_e%'
  AND c.name LIKE 'Go_den_Wattle_Film_'
  AND ct.kind IN ('miscellaneous companies', 'production companies', 'distributors', 'special effects companies')
  AND mi.info LIKE '%rating%'
  AND lt.link LIKE '%prequel%'
  AND ci.nr_order <= 6
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword, mi.info, lt.link
ORDER BY num_movies DESC;

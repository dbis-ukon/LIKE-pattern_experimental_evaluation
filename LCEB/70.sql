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
WHERE cn.name LIKE 'Da_a% %f_r% D%c%'
  AND cn.name LIKE 'Hims_lf - BBC Politi_al Editor'
  AND akat.title LIKE 'Cabin_Fev%'
  AND n.name LIKE 'Sumera_'
  AND k.keyword LIKE '%s%in_'
  AND c.name LIKE 'Thinking _llowed Productions'
  AND ct.kind = 'production companies'
  AND mi.info LIKE '%box office%'
  AND lt.link LIKE '%prequel%'
  AND ci.nr_order IN (3, 1, 4, 20, 11)
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword, mi.info, lt.link
ORDER BY num_movies DESC;

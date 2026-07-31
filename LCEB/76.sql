SELECT a.title, n.name AS actor_name, k.keyword, lt.link
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN name n ON ci.person_id = n.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_link ml ON a.movie_id = ml.movie_id
LEFT JOIN link_type lt ON ml.link_type_id = lt.id
WHERE a.title LIKE 'T_e M%-_L%lpa'
  AND n.name LIKE '%a%i_'
  AND k.keyword LIKE 'st_nd_ng-on_l_dge'
  AND lt.link LIKE '%Sequel%'
  AND a.production_year >= 1923;

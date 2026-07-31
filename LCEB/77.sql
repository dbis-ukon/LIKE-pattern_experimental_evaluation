SELECT DISTINCT a.title, n.name AS actor_name, cn.name AS char_name
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
LEFT JOIN name n ON ci.person_id = n.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '%r_ Ki_t%2_ %t%ni%I%r%But%h%a%r%Cl%I%o_ %i_'
  AND cn.name LIKE 'Charl_s Y. Bewell'
  AND n.name LIKE '_j_d_'
  AND k.keyword LIKE '%ic%a%n_o%-d%t%s'
  AND a.production_year >= 2002;

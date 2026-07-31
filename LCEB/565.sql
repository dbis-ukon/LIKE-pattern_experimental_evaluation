SELECT akat.title, t.title AS original_title, n.name AS actor, cn.name AS character_name
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'De n_cht%r_ie %e%r%'
  AND t.title LIKE 'T_u%t_:%n%r_d%a_er_'
  AND n.name LIKE 'Ci_iljani'
  AND cn.name LIKE '_i%s%o_n'
  AND k.keyword LIKE 'v_nt-min_ng'
  AND ci.nr_order <= 14;

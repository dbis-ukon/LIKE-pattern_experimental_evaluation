SELECT akat.movie_id,
       t.title,
       cn.name AS character_name,
       ci.role_id,
       c.name AS company_name,
       COUNT(DISTINCT akat.movie_id) AS num_movies
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE '_a% A%t'
  AND n.name LIKE 'Pohan'
  AND akat.title LIKE 'To %Wil_'
  AND k.keyword LIKE 'c_pri'
  AND c.name LIKE 'Phrax_s_F_l_s'
  AND t.title LIKE 'Allah ask_ y_ratti'
  AND akat.episode_nr BETWEEN 11 AND 29
GROUP BY akat.movie_id, t.title, cn.name, ci.role_id, c.name
ORDER BY num_movies DESC;

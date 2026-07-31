SELECT akat.movie_id,
       t.title,
       cn.name AS character_name,
       ci.role_id,
       MIN(akat.episode_nr) AS first_episode,
       MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE '_ar_e_l_W_shin_to_'
  AND n.name LIKE 'M_so%Ge_f_'
  AND akat.title LIKE 'T_e _o_an%d_th%at_'
  AND k.keyword LIKE 'tv-executive-producer'
  AND t.title LIKE 'The_Rid_'
  AND akat.episode_nr BETWEEN 1 AND 19
  AND akat.production_year >= 1999
GROUP BY akat.movie_id, t.title, cn.name, ci.role_id
ORDER BY last_episode DESC;

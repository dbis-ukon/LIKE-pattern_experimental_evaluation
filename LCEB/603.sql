SELECT t.id, t.episode_nr
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE 'i_v%t_en_-sca%a_'
  AND t.title LIKE '_e%n_s%t'
  AND n.name LIKE '_w_n_ %r%phe_'
  AND t.episode_nr >= 2
  AND t.season_nr >= 5
  AND n.gender = 'm'
  AND ci.role_id = 4;

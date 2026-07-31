SELECT
    t.title AS movie_title,
    n.name AS actor_name,
    k.keyword,
    t.season_nr,
    MAX(ci.nr_order) AS max_role_order
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (k.keyword LIKE 'merc_des-truc_' OR k.keyword LIKE 'a_i%l-si_e_ick')
  AND ci.nr_order <= 14
  AND n.gender = 'f'
GROUP BY t.title, n.name, k.keyword, t.season_nr
ORDER BY max_role_order DESC;

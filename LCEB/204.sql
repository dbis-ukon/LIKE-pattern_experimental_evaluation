SELECT
    a.title AS aka_title,
    t.title AS movie_title,
    c.name AS character_name,
    co.name AS company_name,
    k.keyword AS movie_keyword,
    MIN(t.season_nr) AS min_season,
    MAX(t.episode_nr) AS max_episode
FROM aka_title a
JOIN title t ON a.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_role_id = c.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'Twenty-One Days Together'
  AND c.name LIKE 'Cad_llac Co_ple'
  AND co.name LIKE 'A.A.F. P_oductions'
  AND ci.nr_order < 1
  AND t.season_nr >= 12
  AND t.episode_nr > 11
GROUP BY a.title, t.title, c.name, co.name, k.keyword
ORDER BY max_episode DESC;

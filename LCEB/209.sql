SELECT
    a.title AS aka_title,
    t.title AS movie_title,
    c.name AS character_name,
    co.name AS company_name,
    k.keyword AS movie_keyword,
    MIN(t.season_nr) AS first_season,
    MAX(t.episode_nr) AS last_episode
FROM aka_title a
JOIN title t ON a.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'T_e Heav_nly _odie_'
  AND c.name LIKE 'L''homme_aux lun_t_es_fo_cées'
  AND co.country_code = '[gb]'
  AND ci.nr_order <= 1
  AND t.season_nr >= 1
  AND t.episode_nr > 3
GROUP BY a.title, t.title, c.name, co.name, k.keyword
ORDER BY last_episode DESC;

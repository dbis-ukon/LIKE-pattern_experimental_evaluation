SELECT
    akat.movie_id,
    t_main.title AS main_title,
    cn_hero.name AS hero_name,
    cn_sidekick.name AS sidekick_name,
    n_hero.gender AS hero_gender,
    n_sidekick.gender AS sidekick_gender,
    SUM(akat.episode_nr) AS total_episodes,
    rt_hero.role AS hero_role
FROM aka_title akat
JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN name n_hero ON cn_hero.id = n_hero.id
JOIN person_info pi_hero ON n_hero.id = pi_hero.person_id
JOIN role_type rt_hero ON ci_hero.role_id = rt_hero.id
JOIN cast_info ci_sidekick ON akat.movie_id = ci_sidekick.movie_id
JOIN char_name cn_sidekick ON ci_sidekick.person_id = cn_sidekick.id
JOIN name n_sidekick ON cn_sidekick.id = n_sidekick.id
JOIN title t_main ON akat.movie_id = t_main.id
WHERE cn_hero.name LIKE 'P%f. _r._H%al_ _a%'
  AND cn_sidekick.name LIKE '%C%e_ %r_'
  AND n_hero.gender = 'm'
  AND n_sidekick.gender = 'f'
  AND t_main.title LIKE 'L%d_n s%''%e'
  AND rt_hero.role LIKE '%Main%'
GROUP BY akat.movie_id, t_main.title, cn_hero.name, cn_sidekick.name, n_hero.gender, n_sidekick.gender, rt_hero.role
ORDER BY total_episodes DESC;

SELECT
    akat.movie_id,
    t_main.title AS main_title,
    cn_hero.name AS hero_name,
    n_hero.gender AS hero_gender,
    COUNT(DISTINCT k_action.keyword) AS action_keywords,
    COUNT(DISTINCT k_adventure.keyword) AS adventure_keywords,
    MIN(akat.season_nr) AS first_season,
    MAX(akat.season_nr) AS last_season
FROM aka_title akat

JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN name n_hero ON cn_hero.id = n_hero.id

JOIN title t_main ON akat.movie_id = t_main.id

JOIN movie_keyword mk_action ON akat.movie_id = mk_action.movie_id
JOIN keyword k_action ON mk_action.keyword_id = k_action.id AND k_action.keyword LIKE '%-%ch'

JOIN movie_keyword mk_adventure ON akat.movie_id = mk_adventure.movie_id
JOIN keyword k_adventure ON mk_adventure.keyword_id = k_adventure.id AND k_adventure.keyword LIKE 'arsenale'

WHERE
    cn_hero.name LIKE '% %n_p%t'
    AND n_hero.gender = 'f'
    AND t_main.title LIKE '_t%k%g%ck'
    AND akat.season_nr IS NOT NULL
    AND akat.production_year >= 1939

GROUP BY akat.movie_id, t_main.title, cn_hero.name, n_hero.gender
ORDER BY adventure_keywords DESC;

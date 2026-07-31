SELECT
    akat.movie_id,
    t_main.title AS main_title,
    t_alt.title AS alt_title,
    cn_hero.name AS hero_name,
    cn_villain.name AS villain_name,
    n_hero.gender AS hero_gender,
    n_villain.gender AS villain_gender,
    COUNT(DISTINCT k_main.keyword) AS main_keywords,
    COUNT(DISTINCT k_alt.keyword) AS alt_keywords
FROM aka_title akat

JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN name n_hero ON cn_hero.id = n_hero.id

JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN name n_villain ON cn_villain.id = n_villain.id

JOIN title t_main ON akat.movie_id = t_main.id
JOIN title t_alt ON akat.movie_id = t_alt.id

JOIN movie_keyword mk_main ON akat.movie_id = mk_main.movie_id
JOIN keyword k_main ON mk_main.keyword_id = k_main.id

JOIN movie_keyword mk_alt ON akat.movie_id = mk_alt.movie_id
JOIN keyword k_alt ON mk_alt.keyword_id = k_alt.id

WHERE
    cn_hero.name LIKE '%i%'''
    AND cn_villain.name LIKE '%e S_ar%e_k'
    AND n_hero.gender = 'f'
    AND n_villain.gender = 'f'
    AND t_main.title LIKE 'Vu_l spel'
    AND t_alt.title LIKE '_ar % Crenca'
    AND k_main.keyword LIKE 's%h_r_-british-_o_umbia'
    AND k_alt.keyword LIKE '%i%gent'
    AND akat.production_year >= 1999

GROUP BY akat.movie_id, t_main.title, t_alt.title, cn_hero.name, cn_villain.name, n_hero.gender, n_villain.gender
ORDER BY main_keywords DESC;

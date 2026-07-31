SELECT
    akat.movie_id,
    t_main.title AS main_title,
    cn_hero.name AS hero_name,
    cn_villain.name AS villain_name,
    c_main.name AS company_name,
    n_hero.gender AS hero_gender,
    n_villain.gender AS villain_gender,
    COUNT(DISTINCT k.keyword) AS keyword_count
FROM aka_title akat

JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN name n_hero ON cn_hero.id = n_hero.id

JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN name n_villain ON cn_villain.id = n_villain.id

JOIN movie_companies mc_main ON akat.movie_id = mc_main.movie_id
JOIN company_name c_main ON mc_main.company_id = c_main.id

JOIN title t_main ON akat.movie_id = t_main.id

JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id

WHERE
    cn_hero.name LIKE 'Ka%a'
    AND cn_villain.name LIKE 'FD_2A'
    AND t_main.title LIKE '%e%e_t'
    AND n_hero.gender = 'm'
    AND n_villain.gender = 'm'
    AND c_main.name LIKE '_a%'
    AND akat.production_year >= 1986

GROUP BY akat.movie_id, t_main.title, cn_hero.name, cn_villain.name, c_main.name, n_hero.gender, n_villain.gender
ORDER BY keyword_count DESC;

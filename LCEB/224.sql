SELECT
    akat.movie_id,
    t_main.title AS main_title,
    t_alt.title AS alt_title,
    cn_villain.name AS villain_name,
    n_villain.gender AS villain_gender,
    c_main.name AS company_name
FROM aka_title akat

JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN name n_villain ON cn_villain.id = n_villain.id

JOIN title t_main ON akat.movie_id = t_main.id
JOIN title t_alt ON akat.movie_id = t_alt.id

JOIN movie_companies mc_main ON akat.movie_id = mc_main.movie_id
JOIN company_name c_main ON mc_main.company_id = c_main.id

WHERE
    cn_villain.name LIKE 'M_j_ C_m%n'
    AND n_villain.gender = 'm'
    AND t_main.title LIKE 'Nan%ia Chan Ch_o'
    AND t_alt.title LIKE '_at%o%'
    AND c_main.country_code = '[mx]'
    AND akat.production_year BETWEEN 1933 AND 2008

ORDER BY akat.movie_id;

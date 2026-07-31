SELECT
    akat.movie_id,
    t_main.title AS main_title,
    cn_villain.name AS villain_name,
    n_villain.gender AS villain_gender,
    c_main.name AS main_company,
    c_alt.name AS alt_company,
    COUNT(DISTINCT k.keyword) AS keyword_count
FROM aka_title akat

JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN name n_villain ON cn_villain.id = n_villain.id

JOIN title t_main ON akat.movie_id = t_main.id

JOIN movie_companies mc_main ON akat.movie_id = mc_main.movie_id
JOIN company_name c_main ON mc_main.company_id = c_main.id

JOIN movie_companies mc_alt ON akat.movie_id = mc_alt.movie_id
JOIN company_name c_alt ON mc_alt.company_id = c_alt.id

JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id

WHERE
    cn_villain.name LIKE 'H_m_el_ -_F_r_r _obs%r'
    AND n_villain.gender = 'm'
    AND t_main.title LIKE '% %S%'
    AND c_main.name LIKE '_ai_ Fil_s%.'
    AND c_alt.name LIKE '_aws%ck_Films'
    AND k.keyword LIKE '%in_ourt-p%-%-_ala%'
    AND akat.production_year >= 2002

GROUP BY akat.movie_id, t_main.title, cn_villain.name, n_villain.gender, c_main.name, c_alt.name
ORDER BY keyword_count DESC;

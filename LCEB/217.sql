SELECT akat.movie_id,
       t_main.title,
       cn_hero.name AS hero_name,
       cn_villain.name AS villain_name,
       n_hero.gender,
       n_villain.gender,
       c_main.name AS main_company,
       c_alt.name AS alt_company,
       k.keyword,
       rt_hero.role AS hero_role,
       rt_villain.role AS villain_role,
       lt.link AS movie_link,
       mi.id AS movie_info_index,
       akat.production_year
FROM aka_title akat
JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN name n_hero ON cn_hero.id = n_hero.id
JOIN role_type rt_hero ON ci_hero.role_id = rt_hero.id
JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN name n_villain ON cn_villain.id = n_villain.id
JOIN role_type rt_villain ON ci_villain.role_id = rt_villain.id
JOIN title t_main ON akat.movie_id = t_main.id
JOIN movie_companies mc_main ON akat.movie_id = mc_main.movie_id
JOIN company_name c_main ON mc_main.company_id = c_main.id
JOIN movie_companies mc_alt ON akat.movie_id = mc_alt.movie_id
JOIN company_name c_alt ON mc_alt.company_id = c_alt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_info_idx mi ON akat.movie_id = mi.movie_id
WHERE cn_hero.name LIKE '%o_s_ Ful%ncio'
  AND cn_villain.name LIKE '_oy Drusk_'
  AND t_main.title LIKE '(2_0%9_03_'
  AND c_main.name LIKE 'The Austr%ian %me_s _ee_l_'
  AND c_alt.name LIKE 'N%a_C%s'
  AND k.keyword LIKE '_old-light-_f-d_y'
  AND rt_hero.role LIKE '%Lead%'
  AND rt_villain.role LIKE '%Supporting%'
  AND lt.link LIKE '%Sequel%'
  AND mi.id IS NOT NULL
  AND akat.production_year BETWEEN 1993 AND 1998
ORDER BY mi.id DESC;

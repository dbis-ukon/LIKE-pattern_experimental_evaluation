SELECT a.title, co.name AS company_name, k.keyword, cn.name AS char_name
FROM aka_title a
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE a.title LIKE '% Lit%e_Ch%'
  AND co.name LIKE 'Mirag_ C_nem_tografica'
  AND cn.name LIKE 'Paul_Renc_u_t'
  AND k.keyword LIKE 'fal%-_y_l_sh_s'
  AND a.production_year BETWEEN 1975 AND 2006
  AND ci.nr_order < 1
  AND co.country_code = '[ca]';

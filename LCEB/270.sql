SELECT a.title, co.name AS company_name, k.keyword
FROM aka_title a
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'R%hi_k Ru_'
  AND co.name LIKE 'C_ne%er%ti_n_l_F% Di%ribu%'
  AND k.keyword LIKE 'southern-_oc_';

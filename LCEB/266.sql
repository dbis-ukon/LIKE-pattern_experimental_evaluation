SELECT a.title, c.name AS character_name, co.name AS company_name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '_r%a %t_e B_t% _f %e %a'
  AND c.name LIKE '%r%i_e%f_U%o%'
  AND co.name LIKE 'An_r_ % P_o_uc_i_n_'
  AND k.keyword LIKE 'asbury-park-new-jersey';

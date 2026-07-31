SELECT a.title, c.name, k.keyword, co.name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE '% %l%h%b%ge'
  AND c.name LIKE '_im%f% %f_r%c_e%N%J%rna_l'
  AND k.keyword LIKE '_r_t%y%'
  AND co.name LIKE '%rc%Blak%i_';

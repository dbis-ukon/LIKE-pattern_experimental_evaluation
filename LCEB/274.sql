SELECT a.title, co.name AS company_name, k.keyword
FROM aka_title a
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE co.name LIKE 'S%l_ul Hou% Fi%s'
  AND a.title LIKE 'Suton'
  AND k.keyword LIKE 't%ec_st'
  AND co.name LIKE '_al_e%A_ven%res';

SELECT a.title, co.name AS company_name, k.keyword, ci.nr_order
FROM aka_title a
INNER JOIN movie_companies mc ON a.movie_id = mc.movie_id
INNER JOIN company_name co ON mc.company_id = co.id
INNER JOIN movie_keyword mk ON a.movie_id = mk.movie_id
INNER JOIN keyword k ON mk.keyword_id = k.id
INNER JOIN cast_info ci ON a.movie_id = ci.movie_id
WHERE a.title LIKE '% _r%es%e%l%io'
  AND co.name LIKE 'Ce%r%ul%ra%a_as% _are_as'
  AND k.keyword LIKE 'f_o_-%-%'
  AND ci.nr_order <= 1
  AND a.production_year BETWEEN 1980 AND 2008;

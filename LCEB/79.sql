SELECT DISTINCT a.title, cn.name AS char_name, co.name AS company_name
FROM aka_title a
INNER JOIN cast_info ci ON a.movie_id = ci.movie_id
INNER JOIN char_name cn ON ci.person_role_id = cn.id
INNER JOIN movie_companies mc ON a.movie_id = mc.movie_id
INNER JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'L%a_s%'
  AND cn.name LIKE 'Jo% S_a%'
  AND co.name LIKE 'Premiere _ict_res'
  AND ci.nr_order < 8
  AND a.production_year >= 1970;

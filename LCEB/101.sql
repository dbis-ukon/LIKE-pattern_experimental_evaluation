SELECT a.title, cn.name AS char_name, co.name AS company_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'T_e _og Who Could Sing'
  AND cn.name LIKE 'V%Ga%L%os'
  AND co.name LIKE 'Premiè_e'
  AND a.production_year >= 2009
  AND ci.nr_order <= 24
  AND mc.company_type_id IS NOT NULL;

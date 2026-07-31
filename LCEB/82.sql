SELECT DISTINCT a.title, cn.name AS char_name, k.keyword, co.name
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_companies mc ON a.movie_id = mc.movie_id
LEFT JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'Tödliche Spur'
  AND cn.name LIKE 'Y%n%'
  AND k.keyword LIKE 'referen_e%o-cam_l%-_he-_tage-%sical'
  AND co.name LIKE '_isual C_eations'
  AND a.production_year BETWEEN 1966 AND 2000;

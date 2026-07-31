SELECT a.title, c.name, co.name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'G%n_la _i s_ie'
  AND c.name LIKE '_ric%n%'
  AND co.name LIKE '_ar%nti% %o_s'
  AND k.keyword LIKE 'jun%in_e_s';

SELECT *
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN company_name co ON ci.person_id = co.id
WHERE akat.title LIKE 'Makin_ Babies'
   OR k.keyword LIKE 'moni%d_m'
   AND cn.name LIKE 'Presid_nt_o%t% Po_i%'
   AND co.name LIKE 'ACa_t%Films'
   AND akat.production_year > 1968;

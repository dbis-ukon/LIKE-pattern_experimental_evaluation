SELECT a.title, c.name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'R_d_Katana'
  AND c.name LIKE 'Walter Otmar'
  AND k.keyword LIKE 'r%s%in%ec_i%-_a%';

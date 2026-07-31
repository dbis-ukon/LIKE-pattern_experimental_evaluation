SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       mk.keyword_id, k.keyword
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'Bio _unter'
  AND k.keyword LIKE '%-_n%i%'
  AND akat.kind_id = 1;

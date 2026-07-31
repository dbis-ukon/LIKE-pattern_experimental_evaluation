SELECT akat.id, akat.title, akat.production_year, akat.kind_id, akat.md5sum,
       mk.keyword_id, k.keyword
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'T% _p_i_i%'
  AND akat.production_year >= 1968
  AND k.keyword LIKE 'iloco%phil_ppi_es';

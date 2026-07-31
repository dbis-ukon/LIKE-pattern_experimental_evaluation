SELECT t.id, akat.title, n.name
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE '_he%la%'
  AND t.title LIKE '_ou_t %/Ha%B%in% _dea'
  AND t.title LIKE 'Somet_in_ in the %r'
  AND n.name LIKE '%d%M_l%y'
  AND k.keyword LIKE 'c_o%ing-block'
  AND ci.nr_order <= 14;

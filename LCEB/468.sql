SELECT n.id, n.name, n.surname_pcode, n.md5sum,
       k.keyword
FROM name n
JOIN movie_keyword mk ON n.imdb_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (n.name LIKE '_ing_' OR n.name LIKE '%n%asi_ W%')
  AND n.name LIKE 'Daly'
  AND k.keyword LIKE 'g%ys%rg-p%l_a%a';

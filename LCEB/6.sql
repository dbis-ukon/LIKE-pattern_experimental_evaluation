SELECT t.id, t.title
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.production_year >= 1987
  AND k.keyword LIKE '_toryt_lling';

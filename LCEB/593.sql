SELECT t.id, t.series_years
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE '%u_t%l%'
  AND t.title LIKE 'W_d%l n%j%'
  AND n.name LIKE '_o%e_'
  AND t.series_years IS NOT NULL
  AND t.season_nr >= 2
  AND n.gender = 'm';

SELECT t.id, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE 'fac_al-pie_cing'
  AND t.title LIKE '%0_5%-%)'
  AND n.name LIKE '_a_i_a%K%a'
  AND t.production_year >= 2011
  AND n.gender = 'm'
  AND ci.nr_order <= 7;

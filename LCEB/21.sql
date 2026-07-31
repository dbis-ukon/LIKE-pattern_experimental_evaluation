SELECT t.id, t.title, mi.info, it.info AS info_type
FROM title t
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (t.title LIKE 'Ju_ge Not Lest_Ye Behea%' or t.title LIKE 'Die_F% d% %t% %n%an_' )
  AND mi.info = 'France:15 September 1981'
  AND it.info = 'book'
  AND k.keyword LIKE '%an%'
  AND t.season_nr >= 1
  AND t.episode_nr >= 1;

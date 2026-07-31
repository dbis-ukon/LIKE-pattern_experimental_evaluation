SELECT t.title, cn.name AS character_name, ci.nr_order, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE ci.nr_order IS NOT NULL
  AND t.season_nr IS NULL
  AND cn.name LIKE '%m%- %'
  AND t.title NOT LIKE '% _is_ _u'
  AND t.episode_nr <= 41
ORDER BY t.production_year;

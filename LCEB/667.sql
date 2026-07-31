SELECT n.name, t.title, t.production_year, pi.info
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.production_year >= 2007
  AND n.name LIKE '%t%at'
  AND t.season_nr = 2
  AND t.production_year BETWEEN 1986 AND 2007
  AND ci.nr_order <= 17
  AND ci.role_id IN (10, 2, 4, 3, 6)
  AND t.title LIKE '_or%n%on%i_t'
ORDER BY t.production_year DESC
LIMIT 100;

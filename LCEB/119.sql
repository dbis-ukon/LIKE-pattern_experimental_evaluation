SELECT co.name, COUNT(DISTINCT n.id) AS linked_people
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN complete_cast cc ON cc.movie_id = t.id
JOIN name n ON n.id = cc.subject_id
WHERE co.name LIKE '%t%cr%mmu%ation_'
  AND n.gender = 'm'
  AND t.production_year BETWEEN 1993 AND 2011
GROUP BY co.name
ORDER BY linked_people DESC;

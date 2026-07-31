SELECT
    t.title,
    c.name,
    ct.kind,
    COUNT(*) AS appearances
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'P%wud%e'
  AND c.name LIKE 'Kai Fa FIl_ Company'
  AND k.keyword LIKE '_ports-_utritio_'
  AND ct.kind LIKE '%distribution%'
  AND t.production_year >= 2008
GROUP BY t.title, c.name, ct.kind
HAVING COUNT(*) > 1;

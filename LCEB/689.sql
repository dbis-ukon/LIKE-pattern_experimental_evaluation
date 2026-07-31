SELECT t.id, t.title, COUNT(DISTINCT akat.id) AS n_aliases
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
WHERE t.title LIKE '_ás _ab_ % d%El p%m_r golp_'
  AND akat.title NOT LIKE 'G%st %i%: %om D%cti_e'
  AND k.keyword LIKE '_err%-_ree%'
  AND cn.name LIKE 'Hatche%ilms'
  AND mc.company_type_id IN (2, 1)
  AND mc.note IS NULL
  AND t.kind_id IN (7, 4, 1, 3)
  AND t.episode_nr IS NULL
  AND t.episode_of_id IS NULL
  AND akat.md5sum IS NOT NULL
  AND cn.country_code = '[us]'
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT akat.id) >= 3
ORDER BY n_aliases DESC
LIMIT 50;

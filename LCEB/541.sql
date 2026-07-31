SELECT akat.title,
       COUNT(DISTINCT t2.id) AS related_titles,
       COUNT(DISTINCT k.id) AS keyword_count,
       COUNT(DISTINCT ci.person_id) AS cast_count
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE '_er Gei_terfl%ge%ky Panky'      -- moderately selective
  AND t.title LIKE 'Yug Dek% Yug _am_a'          -- moderately selective
  AND t2.title LIKE '(2003-12_29)'         -- low selective
  AND k.keyword LIKE '_bandoned-%k'   -- highly selective
  AND n.name LIKE '_on_De%t'          -- moderately selective
  AND cn.name LIKE 'Ru% _a%ni'          -- highly selective
  AND c.name LIKE 'Dark Phoenix Pictures'       -- low selective
GROUP BY akat.title
ORDER BY related_titles DESC;

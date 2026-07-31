SELECT
    t.title,
    COUNT(DISTINCT akat.id) AS alt_titles,
    COUNT(DISTINCT ci.person_id) AS cast_count
FROM title t
JOIN aka_title akat       ON t.id = akat.movie_id
JOIN cast_info ci       ON t.id = ci.movie_id
JOIN char_name cn       ON ci.person_role_id = cn.id
JOIN name n             ON ci.person_id = n.id
WHERE t.kind_id IN (3, 2, 1, 7)
  AND t.production_year BETWEEN 1961 AND 2002
  AND akat.title LIKE 'Sema -_The _arr_or o%Ay%haya'
  AND t.title LIKE '(#3_99_'
  AND n.name LIKE 'Fathipou% Mo'
  AND cn.name LIKE '_pa%'
GROUP BY t.title
ORDER BY alt_titles DESC;

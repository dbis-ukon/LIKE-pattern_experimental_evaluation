SELECT
    akat.title,
    COUNT(DISTINCT k.id) AS kw_count,
    COUNT(DISTINCT c.id) AS company_count,
    COUNT(DISTINCT ci.person_id) AS cast_count
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE akat.title LIKE '% _pe_ial _el%ry'
  AND k.keyword LIKE 'am%n%on%li_'
  AND c.name LIKE '%owe%P_e_s'
  AND n.name LIKE '%rlun%r%'
  AND ci.nr_order <= 3
  AND akat.production_year >= 2006
GROUP BY akat.title
HAVING COUNT(DISTINCT ci.person_id) > 3
ORDER BY kw_count DESC, cast_count DESC;

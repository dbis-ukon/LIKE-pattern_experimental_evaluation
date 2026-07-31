SELECT
    akat.title,
    SUM(CASE WHEN n.gender = 'F' THEN 1 ELSE 0 END) AS female_cast,
    COUNT(DISTINCT c.id) AS companies
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE 'E l_ st_l_e stan_o a gu_rda_e'
  AND akat.title LIKE 'Resurrection Ferns'
  AND c.name LIKE 'S_p_r%a%'
  AND n.name LIKE '%a%a_d_ Jø%n'
  AND ci.nr_order BETWEEN 1 AND 10
  AND akat.kind_id IN (6, 2, 1)
GROUP BY akat.title
HAVING COUNT(DISTINCT ci.person_id) > 5;

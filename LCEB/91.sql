SELECT k.keyword, rt.role, COUNT(DISTINCT ci.movie_id) AS role_count
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE k.keyword LIKE '_e%i%-%o_'
  AND rt.role LIKE '%Supporting%'
  AND ci.nr_order <= 4
  AND t.production_year BETWEEN 1921 AND 1968
GROUP BY k.keyword, rt.role
ORDER BY role_count DESC;

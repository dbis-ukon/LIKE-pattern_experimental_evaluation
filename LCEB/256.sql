SELECT c.name AS company_name, COUNT(DISTINCT k.keyword) AS keyword_count
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
WHERE (cn.name LIKE 'Team Lorem Soccer Coach' OR cn.name LIKE '% %der')
  AND n.gender = 'f'
  AND (n.name LIKE '_o%o%i' OR n.name LIKE 'Goodm_n')
  AND (t.title LIKE '_an%t_d%ooz _ic%r_a_' OR t.title LIKE '%pi_o%i_')
GROUP BY c.name
ORDER BY keyword_count DESC;

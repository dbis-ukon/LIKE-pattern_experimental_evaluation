SELECT cn.name, COUNT(DISTINCT k.id) AS num_keywords
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE cn.name LIKE 'V_ni_a'
  AND k.keyword LIKE '_a_a%e%m_k_ng'
  AND t.production_year BETWEEN 1993 AND 2007
  AND (ci.nr_order <= 10 OR t.season_nr = 1)
GROUP BY cn.name
ORDER BY num_keywords DESC;

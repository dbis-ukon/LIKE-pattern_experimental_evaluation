SELECT c.name AS company_name, COUNT(DISTINCT k.keyword) AS keyword_count, n.gender
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
WHERE (cn.name LIKE 'Pianist Joachim Himmelreic_' OR cn.name LIKE '_e%m_n _e% %')
  AND n.gender = 'f'
  AND (n.name LIKE '_osa%-Sha_' OR n.name LIKE 'Chan')
  AND (t.title LIKE '% Kh%d Ma_es a_Vi_e_:%rammy Family' OR t.title LIKE '_co_e_Noir')
  AND ct.kind = 'special effects companies'
GROUP BY c.name, n.gender
ORDER BY keyword_count DESC;

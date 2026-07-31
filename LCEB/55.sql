SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT mc.company_id) AS num_companies
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE akat.title LIKE 'Curse_of _h_ H_u%Forest'
  AND k.keyword LIKE 'nake%m_le-%t'
  AND c.name LIKE 'Foun%i_h_a_ _r%ct%n'
  AND ct.kind LIKE '%production%'
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;

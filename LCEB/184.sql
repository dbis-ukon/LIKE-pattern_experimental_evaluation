SELECT
    t.title,
    c.name,
    k.keyword,
    COUNT(*) AS appearances
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_role_id = c.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE c.name LIKE 'Barbara Bi_d'
  AND k.keyword NOT LIKE 'oleand%'
  AND t.episode_nr > 3
GROUP BY t.title, c.name, k.keyword
ORDER BY appearances DESC;

SELECT
    c.name AS character_name,
    a.title AS aka_title,
    k.keyword,
    COUNT(DISTINCT t.id) AS movies_count
FROM char_name c
JOIN cast_info ci ON c.id = ci.person_role_id
JOIN title t ON ci.movie_id = t.id
JOIN aka_title a ON t.id = a.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE c.name LIKE 'H%t%m%a%'
  AND a.title LIKE '_h_ An_el W_s a%evil'
  AND k.keyword LIKE 'ref%ence%o-evi_a_the-stage-music_l'
  AND t.season_nr >= 2
  AND t.episode_nr > 41
GROUP BY c.name, a.title, k.keyword
ORDER BY movies_count DESC;

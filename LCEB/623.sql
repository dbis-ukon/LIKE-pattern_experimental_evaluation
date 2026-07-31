SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE 'pants-_t_r_'
)
  AND n.name LIKE 'Ba_nes'
  AND cn.name LIKE 'Ha_ve%o%m%'
  AND t.season_nr >= 1
  AND t.episode_nr >= 3;

SELECT akat.movie_id, cn_hero.name AS hero_name, lt.link AS related_movie, mi.id AS movie_info_index
FROM aka_title akat
JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_info_idx mi ON akat.movie_id = mi.movie_id
WHERE cn_hero.name LIKE 'A_h%am%uker'
  AND lt.link LIKE '%Remake%'
  AND mi.id IS NOT NULL
ORDER BY mi.id DESC;

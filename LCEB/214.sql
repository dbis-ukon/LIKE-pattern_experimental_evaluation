SELECT akat.movie_id, cn_hero.name, rt_hero.role, mi.id AS movie_info_index
FROM aka_title akat
JOIN cast_info ci_hero ON akat.movie_id = ci_hero.movie_id
JOIN char_name cn_hero ON ci_hero.person_id = cn_hero.id
JOIN role_type rt_hero ON ci_hero.role_id = rt_hero.id
JOIN movie_info_idx mi ON akat.movie_id = mi.movie_id
WHERE cn_hero.name LIKE 'Joh_ mcBain'
  AND rt_hero.role LIKE '%Lead%'
  AND mi.id IS NOT NULL
ORDER BY mi.id DESC;

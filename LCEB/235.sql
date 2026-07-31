SELECT cn.name AS character_name,
       ci.role_id,
       MIN(akat.production_year) AS first_year,
       MAX(akat.production_year) AS last_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE '%a% M%h%'
  AND n.name LIKE 'C_oi_ _a_-%'
  AND ci.nr_order <= 14
  AND akat.title LIKE 'Der_Jäger'
  AND t.title LIKE 'T%ud% %y%ry'
  AND k.keyword LIKE 'r%n_n%on%ide-%r%'
  AND k.keyword NOT LIKE 'og_sawara_islan_s-jap_n'
  AND akat.production_year >= 1984
GROUP BY cn.name, ci.role_id
ORDER BY last_year DESC;

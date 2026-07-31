SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name,
       k.keyword AS keyword,
       lt.link AS link_type
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE '_omàs Moli%'
  AND cn.name LIKE '%g%o_ed %n%Mikk%se_'
  AND akat.title LIKE '%sp_ct'
  AND n.name LIKE 'A_ams'
  AND k.keyword LIKE '_h_n%c%e'
  AND c.name LIKE '_a_s%he'
  AND ct.kind IN ('distributors', 'production companies', 'special effects companies', 'miscellaneous companies')
  AND lt.link LIKE '%sequel%'
  AND ci.nr_order IN (21, 12, 4, 14, 30)
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword, lt.link
ORDER BY num_movies DESC;

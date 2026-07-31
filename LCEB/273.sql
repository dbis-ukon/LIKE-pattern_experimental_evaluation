SELECT a.title, c.name AS character_name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '_ien _leibt%ie_'
  AND c.name LIKE 'Discreet Clerk'
  AND k.keyword LIKE '_i_c%-pr_duc%'
  AND k.keyword LIKE 's%a%ad%ntu%';

SELECT a.title, c.name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '%rhyth_'
  AND c.name LIKE '% S% _A_'
  AND k.keyword LIKE 'disguised-as-undertaker'
  AND k.keyword LIKE 'h%k_y_f%';

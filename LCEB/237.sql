SELECT akat.movie_id,
       t.title,
       c.name AS company_name,
       COUNT(DISTINCT cn.name) AS character_count
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE (cn.name LIKE 'V_ic_ % _o%' OR cn.name LIKE '_ejczel Karter')
  AND n.name LIKE 'M_n_u_i'
  AND akat.title LIKE '_traße d% Gewalt'
  AND t.title LIKE 'B_st %'
  AND k.keyword LIKE 'sna_l-sucker'
  AND c.country_code = '[us]'
  AND akat.production_year >= 1999
GROUP BY akat.movie_id, t.title, c.name
ORDER BY character_count DESC;

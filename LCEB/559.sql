SELECT
    akat.title,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    COUNT(DISTINCT k.id) AS keywords
FROM aka_title akat
JOIN title t           ON akat.movie_id = t.id
JOIN cast_info ci      ON t.id = ci.movie_id
JOIN name n            ON ci.person_id = n.id
JOIN movie_keyword mk  ON t.id = mk.movie_id
JOIN keyword k         ON mk.keyword_id = k.id
WHERE n.gender = 'm'
  AND ci.nr_order BETWEEN 7 AND 17
  AND akat.title LIKE '%e% %o%'
  AND t.title LIKE 'R_s_ues_in _he Fi_l%a_d Mou_t_i%'
  AND k.keyword LIKE '%n_th_-beg%ng'
  AND n.name LIKE 'Manr_quez'
GROUP BY akat.title
ORDER BY main_cast DESC;

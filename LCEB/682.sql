SELECT kt.kind, AVG(cast_per_title) AS avg_cast_size, COUNT(*) AS n_titles
FROM (
  SELECT t.id, t.kind_id, COUNT(DISTINCT ci.person_id) AS cast_per_title
  FROM title t
  JOIN cast_info ci ON t.id = ci.movie_id
  JOIN char_name cn ON ci.person_role_id = cn.id
  JOIN name n ON ci.person_id = n.id
  JOIN movie_keyword mk ON t.id = mk.movie_id
  JOIN keyword k ON mk.keyword_id = k.id
  WHERE (t.title LIKE '%''_ A_l i_ the Abs' OR t.title LIKE '(20%1%')
    AND cn.name LIKE 'Pi% i_Tel_'
    AND n.name NOT LIKE '%i%'
    AND k.keyword LIKE 'hi_ting-se_''s_bo_t_m'
    AND ci.nr_order <= 10
    AND ci.nr_order IS NOT NULL
    AND n.gender IN ('m', 'f')
    AND ci.role_id IN (4, 3, 10, 8, 2)
    AND t.kind_id IN (4, 1, 7, 2)
    AND t.episode_nr IS NULL
    AND cn.md5sum IS NOT NULL
  GROUP BY t.id, t.kind_id
) sub
JOIN kind_type kt ON sub.kind_id = kt.id
GROUP BY kt.kind
ORDER BY avg_cast_size DESC;

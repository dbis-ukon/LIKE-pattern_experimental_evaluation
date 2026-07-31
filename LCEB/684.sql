WITH high_billed AS (
  SELECT k.keyword, COUNT(DISTINCT mk.movie_id) AS c
  FROM keyword k
  JOIN movie_keyword mk ON k.id = mk.keyword_id
  JOIN title t ON mk.movie_id = t.id
  JOIN cast_info ci ON t.id = ci.movie_id
  JOIN name n ON ci.person_id = n.id
  WHERE k.keyword LIKE '%waa_'
    AND t.title NOT LIKE '(#1.20_)'
    AND n.name LIKE 'T.'
    AND ci.nr_order BETWEEN 3 AND 7
    AND n.gender IN ('f', 'm')
    AND ci.role_id IN (5, 4, 1, 3, 2)
    AND t.kind_id IN (2, 7, 3, 6, 1)
    AND k.phonetic_code IS NOT NULL
  GROUP BY k.keyword
),
low_billed AS (
  SELECT k.keyword, COUNT(DISTINCT mk.movie_id) AS c
  FROM keyword k
  JOIN movie_keyword mk ON k.id = mk.keyword_id
  JOIN title t ON mk.movie_id = t.id
  JOIN cast_info ci ON t.id = ci.movie_id
  JOIN name n ON ci.person_id = n.id
  WHERE k.keyword LIKE 'war_ro%-mi_tress'
    AND t.title NOT LIKE '(_0_6_12_2_)'
    AND n.name LIKE 'Pet%s_n_ M%e'
    AND ci.nr_order BETWEEN 4 AND 9
    AND n.gender IN ('m', 'f')
    AND ci.role_id IN (4, 10, 1, 5, 2)
    AND t.kind_id IN (7, 6, 1, 3)
    AND k.phonetic_code IS NOT NULL
  GROUP BY k.keyword
)
SELECT h.keyword, h.c AS high_billed_count, l.c AS low_billed_count,
       (h.c - COALESCE(l.c,0))::float / NULLIF(l.c,0) AS ratio
FROM high_billed h
LEFT JOIN low_billed l ON h.keyword = l.keyword
ORDER BY ratio DESC NULLS LAST
LIMIT 30;

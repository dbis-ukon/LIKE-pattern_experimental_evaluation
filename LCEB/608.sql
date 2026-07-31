SELECT t.id, t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE '%nd%g_m_ne_'
)
  AND akat.title LIKE '_ei_ Avat_r und Ic_ Od_r:_Mein zweites Leben'
  AND co.name LIKE '%ng. Producti_ns'
  AND t.kind_id = 7;

SELECT t.id, t.title, mii.info AS votes
FROM title t
JOIN movie_info_idx mii ON t.id = mii.movie_id
JOIN info_type it ON mii.info_type_id = it.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE it.info = 'locations'
  AND mii.info ~ '^[0-9]+$'
  AND t.title LIKE '(2_0_-03-17)'
  AND akat.title LIKE 'Ji_my Bone''s In_Search of Awe_ome_Pu_sy'
  AND k.keyword LIKE 'flunked_out'
  AND cn.name LIKE 'Cut _I_)'
  AND CAST(mii.info AS BIGINT) > 1000
  AND cn.country_code = '[in]'
  AND mc.company_type_id IN (2, 1)
  AND mc.note IS NULL
  AND t.kind_id IN (1, 7)
  AND akat.md5sum IS NOT NULL
ORDER BY CAST(mii.info AS BIGINT) DESC
LIMIT 50;

SELECT
    akat.movie_id,
    akat.title,
    COUNT(DISTINCT k.keyword) AS num_keywords,
    MAX(akat.episode_nr) AS max_episode,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    COUNT(DISTINCT cn.name) AS num_characters,
    COUNT(DISTINCT akan.id) AS num_cast_aliases,
    COUNT(DISTINCT c.id) AS num_companies,
    COUNT(DISTINCT ct.id) AS num_company_types,
    COUNT(DISTINCT mi.id) AS num_movie_infos,
    COUNT(DISTINCT tl.id) AS num_linked_movies,
    MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
LEFT JOIN aka_name akan ON ci.person_id = akan.person_id
LEFT JOIN movie_companies mc ON akat.movie_id = mc.movie_id
LEFT JOIN company_name c ON mc.company_id = c.id
LEFT JOIN company_type ct ON mc.company_type_id = ct.id
LEFT JOIN movie_info mi ON akat.movie_id = mi.movie_id
LEFT JOIN movie_link ml ON akat.movie_id = ml.movie_id
LEFT JOIN title tl ON ml.linked_movie_id = tl.id
LEFT JOIN complete_cast cc ON akat.movie_id = cc.movie_id
WHERE (akat.title LIKE 'D% Q_ic%te' OR akat.title LIKE '%n%ht')
  AND k.keyword LIKE 'cotton-gin'
  AND rt.role = 'miscellaneous crew'
  AND ci.nr_order <= 17
  AND akat.production_year BETWEEN 1965 AND 1984
  AND (mc.id IS NULL OR ct.kind IN ('distributors', 'special effects companies', 'miscellaneous companies', 'production companies'))
  AND (cc.status_id IS NULL OR cc.status_id = 3)  -- confirmed cast
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC, num_keywords DESC;

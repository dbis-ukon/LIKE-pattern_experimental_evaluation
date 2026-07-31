SELECT
    MIN(cn1.name) AS first_company,
    MIN(cn2.name) AS second_company,
    MIN(mi_idx1.info) AS first_rating,
    MIN(mi_idx2.info) AS second_rating,
    MIN(t1.title) AS first_movie,
    MIN(t2.title) AS second_movie
FROM movie_link ml
JOIN link_type lt ON lt.id = ml.link_type_id
JOIN title t1 ON t1.id = ml.movie_id
JOIN title t2 ON t2.id = ml.linked_movie_id AND t1.id <> t2.id
JOIN kind_type kt1 ON kt1.id = t1.kind_id
JOIN kind_type kt2 ON kt2.id = t2.kind_id
JOIN movie_info_idx mi_idx1 ON mi_idx1.movie_id = t1.id
JOIN info_type it1 ON it1.id = mi_idx1.info_type_id
JOIN movie_info_idx mi_idx2 ON mi_idx2.movie_id = t2.id
JOIN info_type it2 ON it2.id = mi_idx2.info_type_id
JOIN movie_companies mc1 ON mc1.movie_id = t1.id
JOIN company_name cn1 ON cn1.id = mc1.company_id
JOIN movie_companies mc2 ON mc2.movie_id = t2.id
JOIN company_name cn2 ON cn2.id = mc2.company_id
JOIN movie_keyword mk ON mk.movie_id = t1.id
JOIN keyword k ON k.id = mk.keyword_id
JOIN complete_cast cc ON cc.movie_id = t1.id
JOIN char_name ch ON ch.id = cc.subject_id
WHERE
    cn1.country_code <> '[br]'
    AND it1.info = 'LD digital sound'
    AND it2.info = 'spouse'
    AND kt1.kind IN ('tv movie', 'tv series', 'movie', 'video movie', 'video game')
    AND kt2.kind IN ('video movie', 'movie', 'tv movie', 'video game', 'tv mini series')
    AND lt.link IN ('referenced in', 'featured in', 'features', 'spoofed in', 'unknown link')
    AND mi_idx2.info < '6.5'
    AND t2.production_year BETWEEN 1995 AND 1999
    AND t1.title LIKE '(201%0_)'
    AND t2.title LIKE 'Bright Angel'
    AND cn1.name LIKE 'Eu%an %r%amer%Co_p_n_'
    AND ch.name LIKE '_o%as';

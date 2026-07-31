SELECT *
FROM aka_title
JOIN movie_keyword ON aka_title.movie_id = movie_keyword.movie_id
JOIN keyword ON movie_keyword.keyword_id = keyword.id
JOIN cast_info ON aka_title.movie_id = cast_info.movie_id
JOIN char_name ON cast_info.person_role_id = char_name.id
JOIN movie_companies ON movie_companies.movie_id = aka_title.movie_id
JOIN company_name ON company_name.id = movie_companies.company_id
WHERE (aka_title.title LIKE '%Action%' AND char_name.name LIKE '%John%')
   OR keyword.keyword LIKE '%Adventure%'
   OR company_name.name LIKE '%Warner%'
   OR (char_name.name LIKE '%Doe%' AND aka_title.title NOT LIKE '%Comedy%')
    AND aka_title.production_year <= 2020
    AND aka_title.title IS NOT NULL
    AND cast_info.nr_order <= 20
    AND aka_title.kind_id IS NOT NULL;

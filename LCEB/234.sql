SELECT akat.movie_id,
       t.title,
       c.name AS company_name,
       k.keyword
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE mc.company_type_id = 2
  AND akat.title LIKE 'Spa_e_Va_pires'
  AND t.title LIKE '_e%h_n%wi_h %r%'
  AND k.keyword LIKE 'standing-on-the-edge-of-a-ro_f'
  AND c.name LIKE 'BTra_n Fi%s'
  AND akat.production_year BETWEEN 1937 AND 2005
  AND akat.episode_nr IS NOT NULL;

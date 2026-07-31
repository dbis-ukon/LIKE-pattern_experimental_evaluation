SELECT t.id AS title_id, t.title AS main_title, n1.name AS actor1, n2.name AS actor2,
       cn1.name AS character1, cn2.name AS character2, k1.keyword AS keyword1, k2.keyword AS keyword2,
       mc1.id AS company1_id, c1.name AS company1_name, ct1.kind AS company1_type,
       mi.info AS movie_info, it.info AS info_type_name
FROM title t
JOIN cast_info ci1 ON t.id = ci1.movie_id
JOIN name n1 ON ci1.person_id = n1.id
JOIN char_name cn1 ON ci1.person_role_id = cn1.id
JOIN cast_info ci2 ON t.id = ci2.movie_id
JOIN name n2 ON ci2.person_id = n2.id
JOIN char_name cn2 ON ci2.person_role_id = cn2.id
JOIN movie_keyword mk1 ON t.id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON t.id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
LEFT JOIN movie_companies mc1 ON t.id = mc1.movie_id
LEFT JOIN company_name c1 ON mc1.company_id = c1.id
LEFT JOIN company_type ct1 ON mc1.company_type_id = ct1.id
LEFT JOIN movie_info mi ON t.id = mi.movie_id
LEFT JOIN info_type it ON mi.info_type_id = it.id
WHERE t.title LIKE 'The Harv_s_'
  AND n1.name LIKE 'F%us_n'
  AND n2.name LIKE '_all'
  AND cn1.name LIKE 'Kim_o Naga_awa'
  AND cn2.name LIKE 'Tom Ve_yard'
  AND k1.keyword LIKE '%vi_t%'
  AND k2.keyword LIKE '_ri%-roc%t'
  AND mc1.id > 711493
  AND ct1.kind = 'miscellaneous companies'
  AND mi.info LIKE '%Award%'
  AND it.info LIKE '%Nomination%'
  AND ci1.nr_order <= 18001
  AND ci2.nr_order <= 28
  AND ci1.role_id = 2
  AND ci2.role_id = 6
  AND t.episode_nr >= 62
  AND t.season_nr >= 21;

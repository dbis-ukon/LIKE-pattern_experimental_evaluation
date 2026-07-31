SELECT t.id AS title_id, t.title AS main_title, at1.title AS aka1, at2.title AS aka2, n1.name AS actor1, n2.name AS actor2,
       cn1.name AS character1, cn2.name AS character2, mc1.id AS company1_id, c1.name AS company1_name,
       mc2.id AS company2_id, c2.name AS company2_name, ct1.kind AS company1_type, ct2.kind AS company2_type
FROM title t
LEFT JOIN aka_title at1 ON t.id = at1.movie_id
LEFT JOIN aka_title at2 ON t.id = at2.movie_id
JOIN cast_info ci1 ON t.id = ci1.movie_id
JOIN name n1 ON ci1.person_id = n1.id
JOIN char_name cn1 ON ci1.person_role_id = cn1.id
JOIN cast_info ci2 ON t.id = ci2.movie_id
JOIN name n2 ON ci2.person_id = n2.id
JOIN char_name cn2 ON ci2.person_role_id = cn2.id
LEFT JOIN movie_companies mc1 ON t.id = mc1.movie_id
LEFT JOIN company_name c1 ON mc1.company_id = c1.id
LEFT JOIN company_type ct1 ON mc1.company_type_id = ct1.id
LEFT JOIN movie_companies mc2 ON t.id = mc2.movie_id
LEFT JOIN company_name c2 ON mc2.company_id = c2.id
LEFT JOIN company_type ct2 ON mc2.company_type_id = ct2.id
JOIN movie_keyword mk1 ON t.id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON t.id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
WHERE t.title LIKE 'T%nk %d It''s Friday'
  AND at1.title LIKE '% (%n%g%oo%)'
  AND at2.title LIKE '_r_ %s_n%n%s%wer'
  AND n1.name LIKE '_oot%D%'
  AND n2.name LIKE '%p_e%um'
  AND cn1.name LIKE 'V% _e%a%'
  AND cn2.name LIKE '_eyt_n%il_y'
  AND c1.name LIKE 'Jos_ph _. S_nger Enter_a%men_'
  AND c2.name LIKE 'DOS Productions'
  AND ct1.kind LIKE '%production%'
  AND ct2.kind LIKE '%distribution%'
  AND k1.keyword LIKE 'tou_i_m'
  AND k2.keyword LIKE '_es_m%fr%d'
  AND ci1.nr_order <= 2
  AND n1.gender = 'm'
  AND ci2.nr_order <= 30
  AND ci1.role_id = 1
  AND ci2.role_id = 1
  AND t.season_nr >= 1
  AND t.episode_nr >= 2;

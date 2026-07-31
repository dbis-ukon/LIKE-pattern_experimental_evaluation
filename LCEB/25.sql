SELECT t.id AS title_id, t.title AS main_title, at1.title AS aka_title1, at2.title AS aka_title2,
       n1.name AS lead_actor, n2.name AS supporting_actor, cn1.name AS hero_character, cn2.name AS villain_character,
       k1.keyword AS primary_keyword, k2.keyword AS secondary_keyword, mc1.id AS production_company_id, c1.name AS production_company_name
FROM title t
LEFT JOIN aka_title at1 ON t.id = at1.movie_id
LEFT JOIN aka_title at2 ON t.id = at2.movie_id
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
WHERE t.title LIKE '(_006-12-11)'
  AND at1.title LIKE 'Fröken Vildkat'
  AND at2.title LIKE 'Hubert vo_ Gois_rn_-%renzen%s'
  AND n1.name LIKE '_a% Ri_h_rd _.'
  AND n2.name LIKE '%d%g_e%á%'
  AND cn1.name LIKE '_omas''father'
  AND cn2.name LIKE '_r%B_itre'
  AND k1.keyword LIKE 'r%nce_t%e_-w_r'
  AND k2.keyword LIKE '%da%'
  AND ci1.nr_order <= 1
  AND ci2.nr_order <= 1
  AND ci1.role_id = 1
  AND ci2.role_id = 1
  AND t.season_nr >= 4
  AND t.episode_nr >= 3
  AND (ct1.kind = 'miscellaneous companies' OR ct1.kind = 'distributors' OR ct1.kind IS NULL);

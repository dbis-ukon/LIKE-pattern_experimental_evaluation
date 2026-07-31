SELECT t.id AS title_id, t.title AS main_title, at1.title AS aka_title, n1.name AS lead_actor, n2.name AS guest_actor,
       cn1.name AS hero_character, cn2.name AS sidekick_character, k1.keyword AS main_keyword, k2.keyword AS sub_keyword,
       mi1.info AS award_info, mi2.info AS trivia_info
FROM title t
LEFT JOIN aka_title at1 ON t.id = at1.movie_id
JOIN cast_info ci1 ON t.id = ci1.movie_id
JOIN name n1 ON ci1.person_id = n1.id
JOIN cast_info ci2 ON t.id = ci2.movie_id
JOIN name n2 ON ci2.person_id = n2.id
JOIN char_name cn1 ON ci1.person_role_id = cn1.id
JOIN char_name cn2 ON ci2.person_role_id = cn2.id
JOIN movie_keyword mk1 ON t.id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON t.id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
LEFT JOIN movie_info mi1 ON t.id = mi1.movie_id
LEFT JOIN info_type it1 ON mi1.info_type_id = it1.id
LEFT JOIN movie_info mi2 ON t.id = mi2.movie_id
LEFT JOIN info_type it2 ON mi2.info_type_id = it2.id
WHERE t.title LIKE 'Una mujer en peligro'
  AND at1.title LIKE '% Cap%of Man_ _r%m_'
  AND n1.name LIKE 'P%ndi'
  AND n2.name LIKE 'S_pur'
  AND cn1.name LIKE '%l% %ce'
  AND cn2.name LIKE 'G_rm_n%'
  AND k1.keyword LIKE 'e%p%o_te%s'
  AND k2.keyword LIKE '%-_l%'
  AND mi1.info LIKE '%Award%'
  AND it1.info LIKE '%Nomination%'
  AND mi2.info LIKE '%Trivia%'
  AND it2.info LIKE '%Fun%'
  AND ci1.nr_order <= 14
  AND ci2.nr_order <= 6
  AND ci1.role_id = 4
  AND ci2.role_id = 1
  AND t.season_nr >= 1
  AND t.episode_nr >= 26;

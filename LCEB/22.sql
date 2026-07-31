SELECT
    t.id AS title_id,
    t.title AS title_name,
    n1.name AS lead_actor,
    n2.name AS supporting_actor,
    cn.name AS character_name,
    k1.keyword AS primary_keyword,
    k2.keyword AS secondary_keyword
FROM title t
JOIN cast_info ci1 ON t.id = ci1.movie_id
JOIN name n1 ON ci1.person_id = n1.id
JOIN cast_info ci2 ON t.id = ci2.movie_id
JOIN name n2 ON ci2.person_id = n2.id
JOIN char_name cn ON ci1.person_role_id = cn.id
JOIN movie_keyword mk1 ON t.id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON t.id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
WHERE t.title LIKE '_id%a%'
  AND n1.name LIKE 'Ts_m%m_n% %a_d_'
  AND n2.name LIKE 'Pasco%'
  AND cn.name LIKE 'Y%ng I_t%n_'
  AND k1.keyword LIKE '%d-o_er-c_m%a-%n_'
  AND k2.keyword LIKE '%d_n_-%f%h%l%'
  AND ci1.nr_order <= 10
  AND ci1.role_id = 1
  AND t.episode_nr >= 22;

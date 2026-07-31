SELECT t.id AS movie_id,
       t.title AS movie_title,
       n.id AS person_id,
       n.name AS actor_name,
       pi1.info AS biography_info,
       it1.info AS biography_type,
       pi2.info AS award_info,
       it2.info AS award_type,
       k.keyword AS keyword_name
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN person_info pi1 ON n.id = pi1.person_id
JOIN info_type it1 ON pi1.info_type_id = it1.id
JOIN person_info pi2 ON n.id = pi2.person_id
JOIN info_type it2 ON pi2.info_type_id = it2.id
LEFT JOIN movie_keyword mk ON t.id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE '% %o_t'
  AND t.title LIKE 'Electra'
  AND n.gender = 'm'
  AND pi1.info = 'Son of ''Monique van de Ven'' (qv) en ''Edwin de Vries'' (qv).'
  AND it1.info = 'article'
  AND pi2.info = '8/30/01: Suffered a heart attack. He never recovered and died at St. John''s Hospital and Medical Center in Santa Monica, CA, 9/2/01.'
  AND it2.info = 'runtimes'
  AND ci.role_id = 1
  AND ci.nr_order <= 20
  AND k.keyword LIKE '%ni%r%';

SELECT t.id AS movie_id,
       t.title AS movie_title,
       n.id AS person_id,
       n.name AS actor_name,
       ci.role_id,
       ci.nr_order,
       cn.name AS character_name,
       pi1.info AS biography_info,
       it1.info AS biography_type,
       pi2.info AS award_info,
       it2.info AS award_type,
       pi3.info AS trivia_info,
       it3.info AS trivia_type,
       k.keyword AS keyword_name,
       c.name AS company_name,
       ct.kind AS company_type
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
JOIN person_info pi1 ON n.id = pi1.person_id
JOIN info_type it1 ON pi1.info_type_id = it1.id
JOIN person_info pi2 ON n.id = pi2.person_id
JOIN info_type it2 ON pi2.info_type_id = it2.id
LEFT JOIN person_info pi3 ON n.id = pi3.person_id
LEFT JOIN info_type it3 ON pi3.info_type_id = it3.id
LEFT JOIN movie_keyword mk ON t.id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_companies mc ON t.id = mc.movie_id
LEFT JOIN company_name c ON mc.company_id = c.id
LEFT JOIN company_type ct ON mc.company_type_id = ct.id
WHERE n.name LIKE '%lson'
  AND n.gender = 'm'
  AND pi1.info LIKE '%Biography%'
  AND it1.info LIKE '%Personal%'
  AND pi2.info LIKE '%Award%'
  AND it2.info LIKE '%Nomination%'
  AND (pi3.info LIKE '%Trivia%' OR pi3.info IS NULL)
  AND (it3.info LIKE '%Fun%' OR it3.info IS NULL)
  AND ci.role_id = 1
  AND ci.nr_order <= 4
  AND t.episode_nr >= 27
  AND t.season_nr >= 1
  AND (ct.kind = 'distributors' OR ct.kind = 'production companies')
  AND k.keyword LIKE 'em%e';

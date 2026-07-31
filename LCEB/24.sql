SELECT
    t.id AS title_id,
    t.title AS title_name,
    mi1.info AS award_info,
    mi2.info AS trivia_info,
    it1.info AS award_type,
    it2.info AS trivia_type,
    k.keyword AS keyword_name
FROM title t
JOIN movie_info mi1 ON t.id = mi1.movie_id
JOIN info_type it1 ON mi1.info_type_id = it1.id
JOIN movie_info mi2 ON t.id = mi2.movie_id
JOIN info_type it2 ON mi2.info_type_id = it2.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '(2000-_2-06)'
  AND mi1.info = 'Canada:R'
  AND mi2.info LIKE '%Trivia%'
  AND it1.info = 'magazine cover photo'
  AND it2.info = 'LD analog right'
  AND k.keyword = 'david-cameron'
  AND t.season_nr >= 4
  AND t.episode_nr >= 110;

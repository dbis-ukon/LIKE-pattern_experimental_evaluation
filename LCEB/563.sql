SELECT t.title, akat.title AS alt_title, n.name AS actor, k.keyword
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '_a%''%i% _ic%p_'
  AND akat.title LIKE '_Ò_ÎÁÄÅÓÅÔ ËÒÁÔËÉ ÏÐÕÓÁ ÚÁ ÇÏÌÑÍ ÅË_ÁÎ'
  AND n.name LIKE 'Ru_in%n'
  AND k.keyword LIKE 's%-_o_n%'
  AND ci.nr_order <= 7;

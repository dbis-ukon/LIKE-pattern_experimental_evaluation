SELECT t.title, n.name AS actor, co.name AS company, k.keyword, akat.title AS alt_title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '%ni% %rld'
  AND akat.title LIKE 'I_ ricco e il _over_'
  AND n.name LIKE 'Pe%y_ _ic_ar_'
  AND k.keyword LIKE 'm%a%viad_ct'
  AND co.name LIKE 'SF%Al_re_ Rode'
  AND ci.nr_order <= 8;

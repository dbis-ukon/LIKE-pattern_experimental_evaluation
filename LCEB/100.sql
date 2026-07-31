SELECT a.title, cn.name, n.name AS actor_name, co.name, k.keyword
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'Corresponde_ce 7'
  AND cn.name LIKE 'L%ely%m%i_l'
  AND n.name LIKE 'B_r%d%v% _a%C%'
  AND co.name LIKE 'P%ato%e_n%e% _r%ns'
  AND k.keyword LIKE 'sec%tary-o_-_efen_e'
  AND a.production_year BETWEEN 1997 AND 2009
  AND ci.nr_order <= 34
  AND co.country_code = '[us]';

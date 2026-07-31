SELECT t.id, t.title
FROM title t
WHERE t.title LIKE '%e% F%s_h% m% Z%'
  AND t.production_year BETWEEN 2002 AND 2005
  AND EXISTS (
      SELECT 1
      FROM aka_title akat
      JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
      JOIN keyword k ON mk.keyword_id = k.id
      JOIN cast_info ci ON akat.movie_id = ci.movie_id
      JOIN name n ON ci.person_id = n.id
      JOIN char_name cn ON ci.person_role_id = cn.id
      JOIN company_name co ON ci.person_id = co.id
      WHERE akat.movie_id = t.id
        AND akat.title LIKE '%Nobu_a%''%rly_Da_s'
        AND k.keyword LIKE '%us-sy_bol'
        AND n.name LIKE 'Re_n_rd'
        AND co.name LIKE 'Filmk%cht'
        AND cn.name LIKE '_a_er_M_r_us'
        AND ci.nr_order <= 1
  );

SELECT t.id, t.series_years
FROM title t
WHERE t.title LIKE '(#_._67)'
  AND t.season_nr >= 1
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
        AND akat.title LIKE 'Without Y_u'
        AND k.keyword LIKE '%lf-_er%a_s'
        AND n.name LIKE '_illandi'
        AND cn.name LIKE '_ims_lf - Swedish Entr_: 3_d Pla_e'
        AND co.name LIKE '%na% Hom%rodu%'
  );

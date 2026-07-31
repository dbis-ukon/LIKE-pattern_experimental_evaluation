SELECT t.id FROM title t
JOIN aka_title akat ON t.id=akat.movie_id
JOIN movie_keyword mk ON t.id=mk.movie_id
JOIN keyword k ON mk.keyword_id=k.id
JOIN cast_info ci ON t.id=ci.movie_id
JOIN name n ON ci.person_id=n.id
JOIN char_name cn ON ci.person_role_id=cn.id
JOIN movie_companies mc ON t.id=mc.movie_id
JOIN company_name co ON mc.company_id=co.id
WHERE k.keyword LIKE 'baby-urina_i_g'
AND t.title LIKE '% v_lle e% calm_'
AND n.name LIKE 'Austen'
AND akat.title LIKE 'Bei m_r n_ch_'
AND co.name LIKE 'P%t_r_s %'
AND cn.name LIKE 'Axelsson as young man'
AND t.production_year = 1992
AND ci.nr_order <= 20
AND mc.company_id > 76674
AND t.kind_id = 2;

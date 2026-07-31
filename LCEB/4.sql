SELECT cn.id, cn.name, t.id AS movie_id, t.title, COUNT(DISTINCT ci.person_id) AS appearances
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE (cn.name LIKE '_om_issa_ H%n%Ha_erk%p' OR cn.name LIKE '%a%r%')
  AND cn.name_pcode_nf = 'C5362'
  AND cn.md5sum IS NOT NULL
  AND t.title LIKE 'Mit_Voll_as in ein neues _eben - Ein Au_ohän%er_z%t nac_ T_xas'
  AND k.keyword NOT LIKE 'refer%-to-g_vin-m_clo_d'
  AND akat.title LIKE 'Eugen_e..%he S_ory o_ Her%ourn_y In_o%rversion'
  AND ci.nr_order <= 57
  AND t.production_year BETWEEN 2002 AND 2010
GROUP BY cn.id, cn.name, t.id, t.title
HAVING COUNT(DISTINCT ci.person_id) >= 2;

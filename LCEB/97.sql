SELECT n.name, cn.name AS char_name, a.title, k.keyword
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN aka_title a ON ci.movie_id = a.movie_id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE 'Ja_a_evi_'
  AND cn.name LIKE '_ax P_r%utt%'
  AND a.title LIKE '_ie %ug%a%s_g_'
  AND k.keyword LIKE '%v%bl%in-%o%a_h'
  AND a.production_year BETWEEN 1978 AND 1986
  AND ci.nr_order <= 1
  AND cn.name_pcode_nf IS NOT NULL;

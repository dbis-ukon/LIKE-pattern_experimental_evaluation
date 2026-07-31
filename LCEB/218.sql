SELECT DISTINCT a.title, c.name AS char_name, co.name AS company_name, k.keyword
FROM aka_title a
JOIN movie_keyword mk ON a.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON a.id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (a.title LIKE '_am_i%e%r%a' OR c.name LIKE 'T%o%x_G_a%' OR co.name LIKE 'Harm_ni_a Fil_s' OR a.title LIKE '_nt%r%S%r%')
  AND k.keyword LIKE '%v_-%r'
  AND a.production_year >= 1982
  AND co.country_code = '[ca]'
  AND ci.nr_order > 4
  AND k.phonetic_code LIKE '%thr%'
  AND mc.note LIKE '%special%'
  AND a.season_nr >= 11;

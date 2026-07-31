SELECT a.title, COUNT(DISTINCT k.id) AS num_keywords, MAX(a.production_year) AS last_year
FROM aka_title a
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE a.title LIKE '_a%f%o_e'
  AND k.keyword LIKE 'refe_e_ce_to%es_i_le-_lo%da'
  AND a.season_nr = 1
  AND a.episode_nr >= 1
GROUP BY a.title
ORDER BY last_year DESC;

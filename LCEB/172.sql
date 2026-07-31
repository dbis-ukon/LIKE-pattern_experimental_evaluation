SELECT a.title, COUNT(DISTINCT k.id) AS keywords, AVG(a.production_year) AS avg_year
FROM aka_title a
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE a.title LIKE 'Re_e_g_ %abu% Ac%'
  AND k.keyword LIKE '_om%ter_ch_p-_n_b_a_n'
  AND a.season_nr >= 1
  AND a.episode_nr >= 4
GROUP BY a.title
ORDER BY keywords DESC;

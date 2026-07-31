SELECT keyword, kind, n_movies,
       RANK() OVER (PARTITION BY kind ORDER BY n_movies DESC) AS rnk
FROM (
  SELECT k.keyword, kt.kind, COUNT(DISTINCT t.id) AS n_movies
  FROM keyword k
  JOIN movie_keyword mk ON k.id = mk.keyword_id
  JOIN title t ON mk.movie_id = t.id
  JOIN kind_type kt ON t.kind_id = kt.id
  JOIN movie_companies mc ON t.id = mc.movie_id
  JOIN company_name cn ON mc.company_id = cn.id
  WHERE (k.keyword LIKE 'unwi_l%r%' OR k.keyword LIKE '_e_inine-be%t_'
      OR k.keyword LIKE '_pla_h%-with-_ate_-f%m_pass_ng-c_r'  OR k.keyword LIKE 'edited-fro%se_ial')
    AND t.title NOT LIKE '%J%m%r%'
    AND cn.name LIKE 'M%ntbat% House'
    AND cn.country_code = '[fr]'
    AND mc.note IS NULL
    AND mc.company_type_id IN (1, 2)
    AND t.kind_id IN (7, 2, 1, 4)
    AND k.phonetic_code IS NOT NULL
  GROUP BY k.keyword, kt.kind
) yr
WHERE n_movies >= 10
ORDER BY kind, rnk
LIMIT 100;

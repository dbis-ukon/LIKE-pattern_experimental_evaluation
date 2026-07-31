SELECT
    a.title AS aka_title,
    t.title AS movie_title,
    c.name AS character_name,
    co.name AS company_name,
    COUNT(DISTINCT n.id) AS num_actors
FROM aka_title a
JOIN cast_info ca ON a.movie_id = ca.movie_id
JOIN char_name c ON ca.person_id = c.id
JOIN complete_cast cc ON a.id = cc.movie_id
JOIN name n ON cc.subject_id = n.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN title t ON a.movie_id = t.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'Vater der Braut'
  AND t.title LIKE '%sc%k S%III'
  AND c.name LIKE '_l%n%r%h_i_'
  AND co.name LIKE '%Yu%'
  AND k.keyword LIKE 'b_ai%wel_ing'
  AND n.name LIKE '_n_erso% Bri_n Chr_sto_her'
  AND c.name NOT LIKE 'C_a_e%'
  AND k.keyword NOT LIKE 'r_nn%g%usi_e%'
  AND ca.nr_order < 6
  AND t.season_nr = 1
GROUP BY a.title, t.title, c.name, co.name
ORDER BY num_actors DESC;

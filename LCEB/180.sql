SELECT
    h.name AS hero_name,
    v.name AS villain_name,
    COUNT(DISTINCT t.id) AS shared_movies
FROM cast_info ci_h
JOIN char_name h ON ci_h.person_role_id = h.id
JOIN cast_info ci_v ON ci_h.movie_id = ci_v.movie_id
JOIN char_name v ON ci_v.person_role_id = v.id
JOIN title t ON ci_h.movie_id = t.id
WHERE h.name LIKE 'Jas_it'
  AND v.name LIKE 'H_t% St_ff _e_be_ _i_na'
  AND ci_h.nr_order <= 4
  AND ci_v.nr_order <= 33
GROUP BY h.name, v.name
ORDER BY shared_movies DESC;

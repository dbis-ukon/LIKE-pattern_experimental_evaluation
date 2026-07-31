SELECT cn.name AS character_name, t.season_nr, MIN(akat.episode_nr) AS first_episode, MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE (cn.name LIKE 'B%n% % C_sin_' OR cn.name LIKE 'Arman%Gara_')
  AND (n.name LIKE 'L%n_ C_nn_e' OR n.name LIKE '_a_b%L_k_')
  AND (t.title LIKE '%t_wa_s w_th_S%g_o_Gon_ale_' OR t.title LIKE 'H_l_ Fr_z%O_er')
GROUP BY cn.name, t.season_nr
ORDER BY t.season_nr, last_episode DESC;

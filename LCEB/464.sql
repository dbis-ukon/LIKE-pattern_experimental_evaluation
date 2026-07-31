SELECT n.id, n.name, n.imdb_index,
       akat.title, akat.episode_nr
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE (n.name LIKE '%rma_her' OR n.name LIKE 'Bur_st_ller')
  AND n.surname_pcode LIKE 'O%'
  AND n.imdb_id > 5000
  AND akat.episode_nr >= 14;

SELECT a.title, c.name AS character_name, n.name AS actor_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN name n ON ci.person_id = n.id
WHERE a.title LIKE '_ru%n% Der _an%e_ %icht%sch_ie_'
  AND c.name LIKE '_e%lmo%'
  AND n.name LIKE 'Gárat% _n%i_';

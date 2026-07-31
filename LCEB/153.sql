SELECT cn.name, COUNT(DISTINCT n.id) AS linked_persons
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN complete_cast cc ON cc.movie_id = ci.movie_id
JOIN name n ON n.id = cc.subject_id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE '_a%e Gromo%'
  AND n.gender = 'f'
  AND t.production_year BETWEEN 1981 AND 2007
  AND cc.status_id IS NOT NULL
  AND t.kind_id IN (2, 7, 1, 4)
GROUP BY cn.name
ORDER BY linked_persons DESC;

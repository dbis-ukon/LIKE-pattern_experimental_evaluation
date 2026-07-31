SELECT t.id, akat.title, k.keyword
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE EXISTS (
    SELECT 1
    FROM cast_info ci
    JOIN name n ON ci.person_id = n.id
    WHERE ci.movie_id = t.id AND n.name LIKE 'Ahlber% H%o'
)
  AND k.keyword LIKE 'roo%qua%er_'
  AND akat.title LIKE 'Last Christmas'
  AND t.kind_id = 7;

SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'missing-wife' OR k.keyword LIKE '_r%atin_-on_a%ain%n_')
  AND k.phonetic_code LIKE 'S%'
  AND k.id > 27311;

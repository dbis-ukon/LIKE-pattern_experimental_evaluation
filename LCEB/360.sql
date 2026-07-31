SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE '_r%lea_'
  AND k.phonetic_code IS NOT NULL
  AND k.id BETWEEN 82828 AND 93799;

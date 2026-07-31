SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'god_s-thumb' OR k.keyword LIKE '_ky-%ty')
  AND k.id BETWEEN 73751 AND 126017
  AND k.phonetic_code LIKE 'M%';

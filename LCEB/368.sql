SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE '_iece_'
  AND k.phonetic_code LIKE 'S%'
  AND k.id > 8033;

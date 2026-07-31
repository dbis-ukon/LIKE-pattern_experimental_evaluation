SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE '%-%-s%'
  AND k.id > 119339
  AND k.phonetic_code IS NOT NULL;

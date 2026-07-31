SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'vienna-woods'
  AND k.id > 22995
  AND k.phonetic_code LIKE 'L%';

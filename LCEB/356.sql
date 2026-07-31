SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'b_ide-to-%'
  AND k.id > 91977
  AND k.phonetic_code LIKE 'C%';

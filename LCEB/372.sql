SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'p_pping-cherry'
  AND k.phonetic_code = 'B242'
  AND k.id > 53817;

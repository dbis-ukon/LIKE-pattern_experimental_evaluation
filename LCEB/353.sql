SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'blo_ter' OR k.keyword LIKE '%o_-d%n%')
  AND k.id > 65887
  AND k.phonetic_code LIKE 'A%';

SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'cosmic-f_lament' OR k.keyword LIKE 'booke_-prize')
  AND k.id > 103016
  AND k.phonetic_code LIKE 'D%';

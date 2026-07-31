SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'semi-trailer' OR k.keyword LIKE 'warr_n-har_ing' OR k.keyword LIKE '%a%f')
  AND k.id < 70
  AND k.phonetic_code LIKE 'T%';

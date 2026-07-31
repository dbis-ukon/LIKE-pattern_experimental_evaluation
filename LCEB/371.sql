SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'k%' OR k.keyword LIKE '%t_e%er_ment')
  AND k.id BETWEEN 70 AND 50222
  AND k.phonetic_code LIKE 'A%';

SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE '%l%n%a%t%-%e%e%' OR k.keyword LIKE 'propri%o_')
  AND k.id BETWEEN 36878 AND 64353
  AND k.phonetic_code IS NOT NULL;

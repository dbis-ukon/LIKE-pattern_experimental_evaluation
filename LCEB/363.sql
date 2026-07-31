SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'e_oti_nal-%moil' OR k.keyword LIKE 'urb_n%')
  AND k.id BETWEEN 90651 AND 97980
  AND k.phonetic_code LIKE 'J%';

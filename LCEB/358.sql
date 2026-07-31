SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'ha_p%c%p%r'
  AND k.phonetic_code LIKE 'R%'
  AND k.id < 61153;

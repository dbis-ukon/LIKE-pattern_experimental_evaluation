SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'ar%apprec_a_i_n'
  AND k.phonetic_code IS NOT NULL
  AND k.id < 82416;

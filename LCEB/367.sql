SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE 'i_t_am_ral-sp_rt' OR k.keyword LIKE 'stevens-pass')
  AND k.id BETWEEN 55867 AND 128399
  AND k.phonetic_code IS NOT NULL;

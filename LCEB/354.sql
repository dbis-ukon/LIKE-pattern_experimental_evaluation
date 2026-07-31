SELECT id, keyword, phonetic_code
FROM keyword k
WHERE k.keyword LIKE 'nyl_n-stock_n_s'
  AND k.id BETWEEN 26030 AND 62914
  AND k.phonetic_code IS NOT NULL;

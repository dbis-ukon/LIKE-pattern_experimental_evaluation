SELECT id, keyword, phonetic_code
FROM keyword k
WHERE (k.keyword LIKE '%c%e%r_d%' OR k.keyword LIKE '_r%p%-th%m_dd_e')
  AND k.phonetic_code LIKE 'C%'
  AND k.id BETWEEN 46711 AND 107548;

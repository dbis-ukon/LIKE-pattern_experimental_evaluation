SELECT id, name, name_pcode_cf, md5sum
FROM name n
WHERE n.name LIKE 'Marxer'
  AND (n.gender = 'm' OR n.name_pcode_nf = 'J3152');

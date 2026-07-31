SELECT id, name, gender, name_pcode_cf
FROM name n
WHERE n.name LIKE '_elest_'
  AND (n.gender = 'f' OR n.name LIKE '%m');

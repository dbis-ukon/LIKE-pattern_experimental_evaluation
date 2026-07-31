SELECT id, name, name_pcode_cf, surname_pcode
FROM name n
WHERE n.name LIKE 'Thaxte% R_land W.'
  AND (n.name LIKE '%l' OR n.gender = 'm');

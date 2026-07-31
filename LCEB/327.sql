SELECT id, name, gender, surname_pcode
FROM name n
WHERE (n.name LIKE 'Bak_r_ C_a_les' OR n.name LIKE 'H%')
  AND n.name LIKE '_rigor_ %ncy'
  AND n.gender = 'm';

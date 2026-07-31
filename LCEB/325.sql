SELECT id, name, surname_pcode, md5sum
FROM name n
WHERE (n.name LIKE '_r%in' OR n.name LIKE 'Coppola')
  AND n.name LIKE '_on%a';

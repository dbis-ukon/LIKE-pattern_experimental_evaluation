SELECT id, name, name_pcode_nf, md5sum
FROM name n
WHERE n.name LIKE 'Ko%seva%ii_'
  AND (n.imdb_index LIKE 'nm%' OR n.gender = 'm');

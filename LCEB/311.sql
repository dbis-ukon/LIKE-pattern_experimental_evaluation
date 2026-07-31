SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE '%n%i_o_' AND cn.name LIKE 'Joh_ _. _a_dwell')
  AND cn.name_pcode_nf = 'H5241'
  AND cn.md5sum LIKE 'k11l12%';

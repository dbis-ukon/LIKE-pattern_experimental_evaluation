SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, ci.nr_order
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
WHERE (cn.name LIKE '_p%s' OR cn.name LIKE 'H_ms_lf - B_po% Inst_tute')
  AND cn.name_pcode_nf = 'F4531'
  AND cn.md5sum IS NOT NULL
  AND ci.nr_order <= 7;

SELECT n.id, n.name, n.md5sum,
       k.keyword
FROM name n
JOIN movie_keyword mk ON n.imdb_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (n.name LIKE 'Giberna_' OR n.name LIKE '_u_c% %na%')
  AND (n.name_pcode_nf = 'H2514' OR n.gender = 'm')
  AND k.keyword LIKE '_t_l_n-_i_s';

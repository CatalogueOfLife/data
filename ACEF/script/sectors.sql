SELECT	
	c.source_database_id AS source_key,
	t.original_id AS id, 
	tt.name,
	tt.rank,
	s.author AS authorship,

	SUBSTRING_INDEX(t.original_id, '-', -1) AS original_id,
	c.sector,
	c.point_of_attachment,
	c.taxon_id

FROM taxonomic_coverage c
	JOIN taxon t ON t.id=c.taxon_id
	JOIN _taxon_tree tt ON tt.taxon_id=c.taxon_id
	LEFT JOIN _search_scientific s ON s.id=c.taxon_id;

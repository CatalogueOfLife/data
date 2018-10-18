
-- creates a text file sources.tsv to be copied into the col_source table in postgres!
SELECT 
	d.id, 
	1000 + d.id, 
	d.name, 
	d.abbreviated_name,
	d.group_name_in_english,
	d.authors_and_editors,
	d.organisation,
	d.contact_person,
	d.version,
	d.release_date,
	d.abstract,
	d.coverage
INTO LOCAL OUTFILE '/Users/markus/sources.tsv'
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n'
FROM source_database d;

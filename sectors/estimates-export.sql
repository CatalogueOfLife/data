
-- write to CSV
SELECT kingdom, lower(rank), replace(name,'\n',' '), estimate, trim(replace(replace(source,'\n',' '),'\r',' ')), inserted, updated
FROM estimates
INTO OUTFILE '/tmp/estimates.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '' 
TERMINATED BY '\t' 
ESCAPED BY '' 
LINES TERMINATED BY '\n';

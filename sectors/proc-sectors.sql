CREATE EXTENSION IF NOT EXISTS intarray;
DROP AGGREGATE if exists array_cat_agg(anyarray);
CREATE AGGREGATE array_cat_agg(anyarray) (
  SFUNC=array_cat,
  STYPE=anyarray
);

DROP TABLE if exists _names;
CREATE TABLE _names (
	id text PRIMARY KEY,
	dataset_id int,
	parent_id text references _names,
	rank text,
	name text,
	authorship text
);

COPY _names FROM '/Users/markus/code/col+/colplus-repo/sectors/assembly_higher_ranks.tsv' CSV DELIMITER E'\t' HEADER NULL '';

CREATE INDEX ON _names (parent_id);
CREATE INDEX ON _names (rank);
ALTER TABLE _names ADD COLUMN species int;
ALTER TABLE _names ADD COLUMN datasets int[];

CREATE EXTENSION IF NOT EXISTS intarray;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP AGGREGATE if exists array_cat_agg(anyarray);
CREATE AGGREGATE array_cat_agg(anyarray) (
  SFUNC=array_cat,
  STYPE=anyarray
);

DROP TABLE if exists names;
CREATE TABLE names (
	_id text UNIQUE,
	dataset_id int,
	_parent_id text references names (_id),
	rank text,
	name text,
	authorship text
);

COPY names FROM '/tmp/parent_child.tsv' NULL 'NULL';

ALTER TABLE names ADD COLUMN id UUID PRIMARY KEY DEFAULT uuid_generate_v4();
ALTER TABLE names ADD COLUMN parent_id UUID references names (id);

-- switch to use uuid as keys
UPDATE names n SET parent_id = p.id
	FROM names p WHERE p._id = n._parent_id;

ALTER TABLE names DROP COLUMN _parent_id;
ALTER TABLE names DROP COLUMN _id;
ALTER TABLE names ADD COLUMN species INT;
ALTER TABLE names ADD COLUMN datasets INT[];
CREATE INDEX ON names (parent_id);
CREATE INDEX ON names (rank);

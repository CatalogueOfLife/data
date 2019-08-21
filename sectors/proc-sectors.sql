CREATE EXTENSION IF NOT EXISTS intarray;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP AGGREGATE if exists array_cat_agg(anyarray);
CREATE AGGREGATE array_cat_agg(anyarray) (
  SFUNC=array_cat,
  STYPE=anyarray
);


DROP TABLE if exists estimates;
CREATE TABLE estimates (
	kingdom text, 
	rank text, 
	name text, 
	estimate int, 
	source text, 
	created timestamp, 
	modified timestamp	
);

COPY estimates FROM '/tmp/estimates.tsv' NULL 'NULL';
-- remove bad estimates
DELETE FROM estimates WHERE name='Not assigned' OR estimate is null;
UPDATE estimates set kingdom = 'Animalia' WHERE kingdom='' and name = 'Orthoptera';
UPDATE estimates set kingdom = NULL WHERE kingdom='';
ALTER TABLE estimates ALTER COLUMN kingdom set NOT NULL;
ALTER TABLE estimates ADD COLUMN key SERIAL PRIMARY KEY;

DROP TABLE if exists names;
CREATE TABLE names (
	_id text UNIQUE,
	dataset_id int,
	_parent_id text references names (_id),
	rank text,
	name text
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
ALTER TABLE names ADD COLUMN kingdom TEXT;
CREATE INDEX ON names (parent_id);
CREATE INDEX ON names (rank);


-- update names kingdom for only the names that match estimate names
CREATE OR REPLACE FUNCTION kingdom(v_id UUID) RETURNS TEXT AS $$
	declare king TEXT;
BEGIN
	WITH RECURSIVE x AS(
		SELECT name, parent_id FROM names WHERE id = v_id
	  UNION
		SELECT n.name, n.parent_id FROM names n, x WHERE n.id = x.parent_id
	)
	SELECT name INTO king FROM x WHERE parent_id IS NULL;
    RETURN (king);
END;
$$ LANGUAGE plpgsql;


UPDATE names n SET kingdom = kingdom(n.id)
	FROM estimates e
	WHERE e.rank=n.rank AND n.name=e.name;

CREATE INDEX ON names (name, rank, kingdom);

-- report unmatching estimates
SELECT e.kingdom,e.rank, e.name AS missingName FROM estimates e LEFT JOIN names n ON e.rank=n.rank AND e.name=n.name AND e.kingdom=n.kingdom
	WHERE n.id IS NULL ORDER BY e.rank, e.name;
SELECT e.key,e.kingdom,e.rank, e.name, array_agg(n.name), array_agg(n.kingdom) 
	FROM estimates e 
		JOIN names n ON e.rank=n.rank AND e.name=n.name AND e.kingdom=n.kingdom
	GROUP BY e.key
	HAVING count(*) > 1;
-- export estimate references
CREATE TABLE refs AS SELECT DISTINCT trim(source) AS source FROM estimates WHERE coalesce(source,'') != '';
ALTER TABLE refs ADD COLUMN key SERIAL PRIMARY KEY;
COPY (SELECT 'id','citation' UNION ALL 
	  SELECT key::text, source FROM refs) TO '/tmp/reference.csv' WITH CSV;
-- export estimate decision
COPY (SELECT 'subject_code','subject_rank','subject_name','subject_id','estimate','reference_id','created','modified' UNION ALL 
  -- 0 BACTERIAL
  -- 1 BOTANICAL
  -- 3 VIRUS
  -- 4 ZOOLOGICAL
	SELECT CASE e.kingdom 
		WHEN 'Animalia' THEN 4
		WHEN 'Plantae' THEN 1
		WHEN 'Fungi' THEN 1
		WHEN 'Bacteria' THEN 0
		WHEN 'Archaea' THEN 0
		WHEN 'Viruses' THEN 3
		WHEN 'Chromista' THEN NULL
		WHEN 'Protozoa' THEN NULL
		ELSE NULL
		END,
		lower(e.rank),e.name,n.id::text,e.estimate::text,r.key::text,e.created::text,e.modified::text
	  FROM estimates e 
	  	LEFT JOIN names n ON e.rank=n.rank AND e.name=n.name AND e.kingdom=n.kingdom
	  	LEFT JOIN refs r ON r.source=e.source
) TO '/tmp/estimate.csv' WITH CSV;

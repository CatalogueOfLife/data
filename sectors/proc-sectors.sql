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
ALTER TABLE names ADD COLUMN major_dataset INT;
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


-- calculate major dataset by looking at direct children only
DO $$ 
DECLARE
  ranks text[] := ARRAY['subgenus', 'genus', 'family', 'superfamily', 'order', 'class', 'phylum', 'kingdom'];
  major int;
  r text;
BEGIN
  FOREACH r IN ARRAY ranks LOOP
    RAISE NOTICE 'Update major dataset for rank %', r;
    
    WITH childs AS (
    	SELECT nid, did, cnt, RANK() OVER (PARTITION BY nid ORDER BY cnt DESC) AS rn
   		FROM (
		    SELECT n.id AS nid, coalesce(c.major_dataset,c.dataset_id) AS did, count(*) AS cnt
		    FROM names n JOIN names c ON c.parent_id=n.id
		    WHERE n.rank=r
		    GROUP BY n.id, coalesce(c.major_dataset,c.dataset_id)
		) AS childsAll LIMIT 1
	)
	UPDATE names n SET major_dataset=coalesce(c.did,n.dataset_id)
    	FROM childs c
    	WHERE c.nid=n.id AND n.rank=r;
  END LOOP;  
END $$;
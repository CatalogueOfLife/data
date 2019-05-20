
DROP TABLE IF EXISTS parent_child;
CREATE TABLE parent_child (
  id VARCHAR(200), INDEX(ID(200)),
  database_id VARCHAR(4), INDEX(database_id),
  parent_id VARCHAR(200), INDEX(parent_id(200)),
  `rank` varchar(20), INDEX(`rank`),
  name varchar(100), INDEX(name(100)),
  authorship varchar(200), INDEX(authorship(200))
)
SELECT *
FROM (
       -- kingdom
       SELECT kingdom   AS id,
              NULL      AS database_id,
              NULL      AS parent_id,
              "kingdom" AS `rank`,
              kingdom   AS `name`
       FROM families
       WHERE kingdom IS NOT NULL
       GROUP BY kingdom

       UNION 

       -- phylum
       SELECT CONCAT_WS("_", kingdom, phylum) AS id,
              NULL                            AS database_id,
              kingdom                         AS parent_id,
              "phylum"                        AS `rank`,
              phylum                          AS `name`
       FROM families
       WHERE phylum IS NOT NULL
       GROUP BY kingdom, phylum

       UNION 

       -- class
       SELECT CONCAT_WS("_", kingdom, phylum, class) AS id,
              NULL                                   AS database_id,
              CONCAT_WS("_", kingdom, phylum)        AS parent_id,
              "class"                                AS `rank`,
              class                                  AS `name`
       FROM families
       WHERE `class` IS NOT NULL
       GROUP BY kingdom, phylum, class

       UNION 

       -- order
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`) AS id,
              NULL                                            AS database_id,
              CONCAT_WS("_", kingdom, phylum, class)          AS parent_id,
              "order"                                         AS `rank`,
              `order`                                         AS `name`
       FROM families
       WHERE `order` IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`

       UNION 

       -- superfamily
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily) AS id,
              NULL                                                         AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`)              AS parent_id,
              "superfamily"                                                AS `rank`,
              superfamily                                                  AS name
       FROM families
       WHERE superfamily IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`, superfamily

       UNION 

       -- family
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family) AS id,
              NULL                                                                 AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily)         AS parent_id,
              "family"                                                             AS `rank`,
              family                                                               AS name
       FROM families
       WHERE family IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`, superfamily, family

       UNION 

       -- genus
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus) AS id,
              NULL                                                                        AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family)        AS parent_id,
              "genus"                                                                     AS `rank`,
              genus                                                                       AS name
       FROM scientific_names SN INNER JOIN families FAM ON SN.family_code = FAM.family_code
       WHERE genus IS NOT NULL AND sp2000_status_id IN (1,4)
       GROUP BY kingdom, phylum, class, `order`, superfamily, family, genus

       UNION 

       -- species
       SELECT SN.record_id                       AS id,
              SN.database_id                  AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus) AS parent_id,
              "species"                       AS `rank`,
              CONCAT_WS(" ", genus, species)  AS name
       FROM scientific_names SN INNER JOIN families FAM ON SN.family_code = FAM.family_code
       WHERE species IS NOT NULL AND species != '' 
              AND (infraspecies IS NULL OR infraspecies = '') 
              AND sp2000_status_id IN (1,4)
     ) U ORDER BY parent_id;


-- write to CSV
SELECT lower(id), database_id, lower(parent_id), `rank`, replace(name,'\n',' '), replace(authorship,'\n',' ')
FROM parent_child
INTO OUTFILE '/tmp/parent_child.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '' 
TERMINATED BY '\t' 
ESCAPED BY '' 
LINES TERMINATED BY '\n';

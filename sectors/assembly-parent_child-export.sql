DELETE FROM Assembly_Global.families WHERE record_id = 20541; -- eliminate duplicate family_code
UPDATE Assembly_Global.scientific_names SET genus='Simulium' WHERE genus=CONVERT('SImulium', BINARY) AND database_id=101; -- fix typo
UPDATE Assembly_Global.scientific_names SET genus='Epichloe' WHERE genus=CONVERT('Epichloë', BINARY) AND database_id=28; -- remove diacritic in genus
DELETE FROM Assembly_Global.scientific_names WHERE name_code IN ('Scr-17308', 'Crb-1000571', 'Crb-372451', 'Crb-372452'); -- remove 'v' genus in Crb and blank record in Scr

UPDATE Assembly_Global.families SET kingdom=trim(kingdom);
UPDATE Assembly_Global.families SET phylum=trim(phylum);
UPDATE Assembly_Global.families SET class=trim(class);
UPDATE Assembly_Global.families SET `order`=trim(`order`);
UPDATE Assembly_Global.families SET family=trim(family);
UPDATE Assembly_Global.families SET superfamily=trim(superfamily);
UPDATE Assembly_Global.families SET family_code=trim(family_code);
UPDATE Assembly_Global.families SET database_id=trim(database_id);
UPDATE Assembly_Global.families SET superfamily=NULL WHERE superfamily='';
UPDATE Assembly_Global.families SET family_code=NULL WHERE family_code='';

UPDATE Assembly_Global.scientific_names SET genus=trim(genus);
UPDATE Assembly_Global.scientific_names SET subgenus=trim(subgenus);
UPDATE Assembly_Global.scientific_names SET species=trim(species);
UPDATE Assembly_Global.scientific_names SET infraspecies=trim(infraspecies);
UPDATE Assembly_Global.scientific_names SET infraspecies_marker=trim(infraspecies_marker);
UPDATE Assembly_Global.scientific_names SET author=trim(author);
UPDATE Assembly_Global.scientific_names SET infraspecies_parent_name_code=trim(infraspecies_parent_name_code);
UPDATE Assembly_Global.scientific_names SET accepted_name_code=trim(accepted_name_code);
UPDATE Assembly_Global.scientific_names SET name_code=trim(name_code);
UPDATE Assembly_Global.scientific_names SET database_id=trim(database_id);
UPDATE Assembly_Global.scientific_names SET family_code=trim(family_code);
UPDATE Assembly_Global.scientific_names SET subgenus=NULL WHERE subgenus='';
UPDATE Assembly_Global.scientific_names SET infraspecies=NULL WHERE infraspecies='';
UPDATE Assembly_Global.scientific_names SET infraspecies_marker=NULL WHERE infraspecies_marker='';
UPDATE Assembly_Global.scientific_names SET infraspecies_parent_name_code=NULL WHERE infraspecies_parent_name_code='';
UPDATE Assembly_Global.scientific_names SET author=NULL WHERE author='';
UPDATE Assembly_Global.scientific_names SET family_code=NULL WHERE family_code='';

DROP TABLE IF EXISTS Assembly_Global_Sectors.sectors;
CREATE TABLE Assembly_Global_Sectors.sectors (
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
              kingdom   AS `name`,
              NULL      AS authorship
       FROM families
       WHERE kingdom IS NOT NULL
       GROUP BY kingdom

       UNION ALL

       -- phylum
       SELECT CONCAT_WS("_", kingdom, phylum) AS id,
              NULL                            AS database_id,
              kingdom                         AS parent_id,
              "phylum"                        AS `rank`,
              phylum                          AS `name`,
              NULL                            AS authorship
       FROM families
       WHERE phylum IS NOT NULL
       GROUP BY kingdom, phylum

       UNION ALL

       -- class
       SELECT CONCAT_WS("_", kingdom, phylum, class) AS id,
              NULL                                   AS database_id,
              CONCAT_WS("_", kingdom, phylum)        AS parent_id,
              "class"                                AS `rank`,
              class                                  AS `name`,
              NULL                                   AS authorship
       FROM families
       WHERE `class` IS NOT NULL
       GROUP BY kingdom, phylum, class

       UNION ALL

       -- order
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`) AS id,
              NULL                                            AS database_id,
              CONCAT_WS("_", kingdom, phylum, class)          AS parent_id,
              "order"                                         AS `rank`,
              `order`                                         AS `name`,
              NULL                                            AS authorship
       FROM families
       WHERE `order` IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`

       UNION ALL

       -- superfamily
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily) AS id,
              database_id                                                  AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`)              AS parent_id,
              "superfamily"                                                AS `rank`,
              superfamily                                                  AS name,
              NULL                                                         AS authorship
       FROM families FAM
       WHERE superfamily IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`, superfamily

       UNION ALL

       -- family
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family) AS id,
              database_id                                                          AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily)         AS parent_id,
              "family"                                                             AS `rank`,
              family                                                               AS name,
              NULL                                                                 AS authorship
       FROM families FAM
       WHERE family IS NOT NULL
       GROUP BY kingdom, phylum, class, `order`, superfamily, family

       UNION ALL

       -- genus
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus) AS id,
              SN.database_id AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family) AS parent_id,
              "genus" AS `rank`,
              genus as name,
              NULL AS authorship
       FROM scientific_names SN INNER JOIN families FAM ON SN.family_code = FAM.family_code OR SN.family_id = FAM.record_id
       WHERE genus IS NOT NULL AND sp2000_status_id IN (1,4)
       GROUP BY kingdom, phylum, class, `order`, superfamily, family, genus

       UNION ALL

       -- subgenus
       SELECT CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus, subgenus) AS id,
              SN.database_id AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus) AS parent_id,
              "subgenus" AS `rank`,
              subgenus as name,
              NULL AS authorship
       FROM scientific_names SN INNER JOIN families FAM ON SN.family_code = FAM.family_code OR SN.family_id = FAM.record_id
       WHERE subgenus IS NOT NULL AND sp2000_status_id IN (1,4)
       GROUP BY kingdom, phylum, class, `order`, superfamily, family, genus, subgenus

       UNION ALL

       SELECT name_code AS id,
              SN.database_id AS database_id,
              CONCAT_WS("_", kingdom, phylum, class, `order`, superfamily, family, genus, subgenus) AS parent_id,
              "species" AS `rank`,
              CONCAT_WS(" ", genus, species) as name,
              author AS authorship
       FROM scientific_names SN INNER JOIN families FAM ON SN.family_code = FAM.family_code OR SN.family_id = FAM.record_id
       WHERE species IS NOT NULL AND species != '' AND sp2000_status_id IN (1,4)
       GROUP BY kingdom, phylum, class, `order`, superfamily, family, genus, subgenus, species
     ) U ORDER BY parent_id;

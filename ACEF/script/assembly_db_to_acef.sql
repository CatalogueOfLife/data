
# This SQL script is a template for the SQL that is to be run
# in order to generate the ACEF files (e.g. AcceptedSpecies.tsv,
# AcceptedInfraspecificTaxa.tsv, etc.). It is meant to be run
# by the make-acef.sh script, which uses sed to replace
# __OUTPUT_DIR__ and __DATABASE_ID__ with proper values.


/* 
 * AcceptedSpecies.tsv
 */
SELECT 
'AcceptedTaxonID','Kingdom','Phylum', 'Class', 'Order', 'Superfamily', 'Family', 'Genus', 'SubGenusName', 
'SpeciesEpithet', 'AuthorString', 'GSDNameStatus', 'Sp2000NameStatus', 'IsExtinct', 'HasPreHolocene',
'HasModern', 'LifeZone', 'AdditionalData', 'LTSSpecialist', 'LTSDate','SpeciesURL', 'GSDTaxonGUID', 'GSDNameGUID'
UNION
SELECT sn.name_code					AS AcceptedTaxonID
,	N2E(fam.kingdom)				AS Kingdom
,	N2E(fam.phylum)					AS Phylum
,	N2E(fam.class)					AS Class
,	N2E(fam.`order`)				AS `Order`
,	N2E(fam.superfamily)			AS Superfamily
,	N2E(fam.family)					AS Family
,	N2E(sn.genus)					AS Genus
,	N2E(sn.subgenus)				AS SubGenusName
,	N2E(sn.species)					AS SpeciesEpithet
,	CLEAN_STR(sn.author) 			AS AuthorString
,	''								AS GSDNameStatus /* ??? */
,	N2E(nomstatus.sp2000_status)	AS Sp2000NameStatus
,	N2E(sn.is_extinct)				AS IsExtinct
,	N2E(sn.has_preholocene)			AS HasPreHolocene
,	N2E(sn.has_modern)				AS HasModern
,	N2E(lz.lifezones)				AS LifeZone
,	CLEAN_STR(sn.comment) 			AS AdditionalData
,	N2E(sp.specialist_name)			AS LTSSpecialist
,	N2E(sn.scrutiny_date)			AS LTSDate
,	N2E(sn.web_site)				AS SpeciesURL
,	N2E(sn.GSDTaxonGUID)			AS GSDTaxonGUID
,	N2E(sn.GSDNameGUID)				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/AcceptedSpecies.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM scientific_names AS sn
LEFT JOIN families AS fam ON (sn.family_code = fam.family_code)
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_code = sp.specialist_code)
WHERE (sn.infraspecies IS NULL OR sn.infraspecies = '')
AND sn.sp2000_status_id IN (1,4)
AND sn.database_id=__DATABASE_ID__;


/* 
 * AcceptedInfraspecificTaxa.tsv
 */
SELECT 'AcceptedTaxonID','parentID','InfraSpeciesEpithet','InfraSpeciesMarker','InfraSpeciesAuthorString',
 'GSDNameStatus','Sp2000NameStatus','IsExtinct','HasPreHolocene','HasModern','LifeZone','AdditionalData',
 'LTSSpecialist','LTSDate','InfraSpeciesURL','GSDTaxonGUID','GSDNameGUID'
UNION
SELECT sn.name_code					AS AcceptedTaxonID
,	N2E(sn.infraspecies_parent_name_code)	AS parentID
,	N2E(sn.infraspecies)			AS InfraSpeciesEpithet
,	N2E(sn.infraspecies_marker)		AS InfraSpeciesMarker
,	N2E(sn.author)					AS InfraSpeciesAuthorString
,	''								AS GSDNameStatus /* GSDNameStatus is provided by the GSDs */
,	N2E(nomstatus.sp2000_status)	AS Sp2000NameStatus
,	N2E(sn.is_extinct)				AS IsExtinct
,	N2E(sn.has_preholocene)			AS HasPreHolocene
,	N2E(sn.has_modern)				AS HasModern
,	CLEAN_STR(lz.lifezones)			AS LifeZone
,	CLEAN_STR(sn.comment)			AS AdditionalData
,	N2E(sp.specialist_name)			AS LTSSpecialist
,	N2E(sn.scrutiny_date)			AS LTSDate
,	N2E(sn.web_site)				AS InfraSpeciesURL
,	N2E(sn.GSDTaxonGUID)			AS GSDTaxonGUID
,	N2E(sn.GSDNameGUID)				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/AcceptedInfraspecificTaxa.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_code = sp.specialist_code)
WHERE (sn.infraspecies IS NOT NULL OR sn.infraspecies !='')
AND sn.sp2000_status_id IN (1,4)
AND sn.database_id=__DATABASE_ID__;


/* 
 * Synonyms.tsv
 */
SELECT 'ID','AcceptedTaxonID','Genus','SubGenusName','SpeciesEpithet','AuthorString','InfraSpeciesEpithet',
'InfraSpeciesMarker','InfraSpeciesAuthorString','GSDNameStatus','Sp2000NameStatus','GSDNameGUID'
UNION
SELECT sn.name_code					AS ID
,	N2E(sn.accepted_name_code)		AS AcceptedTaxonID
,	N2E(sn.genus)					AS Genus
,	N2E(sn.subgenus)				AS SubGenusName
,	N2E(sn.species)					AS SpeciesEpithet
,	IF((sn.infraspecies IS NULL), N2E(sn.author), '')	AS AuthorString
,	N2E(sn.infraspecies)			AS InfraSpeciesEpithet
,	N2E(sn.infraspecies_marker)		AS InfraSpeciesMarker
,	IF((sn.infraspecies IS NULL), '', N2E(sn.author))	AS InfraSpeciesAuthorString
,	''								AS GSDNameStatus /* GSDNameStatus is provided by the GSDs */
,	N2E(nomstatus.sp2000_status)	AS Sp2000NameStatus
,	N2E(sn.GSDNameGUID)				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/Synonyms.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
WHERE sn.sp2000_status_id IN (2,3,5)
AND sn.database_id=__DATABASE_ID__;


/*
 * CommonNames.tsv
 */
SELECT 'AcceptedTaxonID','CommonName','TransliteratedNames','Language','Country','Area','ReferenceID'
UNION
SELECT cn.name_code					AS AcceptedTaxonID
,	CLEAN_STR(cn.common_name)		AS CommonName
,	N2E(cn.transliteration)			AS TransliteratedNames
,	N2E(cn.language)				AS Language
,	N2E(cn.country)					AS Country
,	CLEAN_STR(cn.area)				AS Area
,	N2E(cn.reference_code)			AS ReferenceID
INTO OUTFILE '__OUTPUT_DIR__/CommonNames.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM common_names AS cn
LEFT JOIN scientific_names sn ON (cn.name_code = sn.name_code AND sn.database_id = cn.database_id)
WHERE cn.database_id=__DATABASE_ID__;


/*
 * Distribution.tsv
 */
SELECT 'AcceptedTaxonID','DistributionElement','StandardInUse','DistributionStatus'
UNION
SELECT d.name_code					AS AcceptedTaxonID
,	CLEAN_STR(d.distribution)		AS DistributionElement
,	N2E(d.StandardInUse)			AS StandardInUse
,	N2E(d.DistributionStatus)		AS DistributionStatus
INTO OUTFILE '__OUTPUT_DIR__/Distribution.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM distribution AS d
WHERE d.database_id=__DATABASE_ID__;


/*
 * References.tsv
 */
SELECT 'ReferenceID','Authors','Year','Title','Details'
UNION
SELECT r.reference_code				AS ReferenceID
,	CLEAN_STR(r.author)				AS Authors
,	CLEAN_STR(r.year)				AS Year
,	CLEAN_STR(r.title)				AS Title
,	CLEAN_STR(r.source)				AS Details
INTO OUTFILE '__OUTPUT_DIR__/References.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM `references` AS r
WHERE r.database_id=__DATABASE_ID__;



/*
 * NameReferences.tsv
 */
/*SELECT 'ID','ReferenceType','ReferenceID'
UNION */
SELECT snr.name_code				AS ID
,	N2E(snr.reference_type)			AS ReferenceType
,	N2E(snr.reference_code)			AS ReferenceID
INTO OUTFILE '__OUTPUT_DIR__/NameReferences.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM scientific_name_references AS snr
WHERE snr.database_id=__DATABASE_ID__;


/*
 * SourceDatabase.tsv
 */
SELECT 'DatabaseFullName','DatabaseShortName','DatabaseVersion','ReleaseDate','AuthorsEditors','TaxonomicCoverage',
'GroupNameInEnglish','Abstract','Organization','HomeURL','Coverage','Completeness','Confidence',
'LogoFileName','ContactPerson'
UNION
SELECT db.database_full_name		AS DatabaseFullName
,	N2E(db.database_name)			AS DatabaseShortName
,	N2E(db.version)					AS DatabaseVersion
,	N2E(db.release_date)			AS ReleaseDate
,	N2E(db.authors_editors)			AS AuthorsEditors
,	CLEAN_STR(db.taxonomic_coverage)	AS TaxonomicCoverage
,	CLEAN_STR(db.taxa)								AS GroupNameInEnglish
,	CLEAN_STR(db.abstract)			AS Abstract
,	N2E(db.organization)			AS Organization
,	N2E(db.web_site)				AS HomeURL
,	N2E(db.coverage)				AS Coverage
,	N2E(db.completeness)			AS Completeness
,	N2E(db.confidence)				AS Confidence
,	''								AS LogoFileName
,	N2E(db.contact_person)			AS ContactPerson
INTO OUTFILE '__OUTPUT_DIR__/SourceDatabase.tsv'
CHARACTER SET UTF8MB4
FIELDS ENCLOSED BY '"' 
TERMINATED BY '\t' 
ESCAPED BY '\\' 
LINES TERMINATED BY '\n'
FROM `databases` AS db
WHERE db.record_id=__DATABASE_ID__;


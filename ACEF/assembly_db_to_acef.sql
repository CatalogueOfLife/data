/* 
 * AcceptedSpecies.txt
 */
SELECT 
'AcceptedTaxonID','Kingdom','Phylum', 'Class', 'Order', 'Superfamily', 'Family', 'Genus', 'SubGenusName', 
'SpeciesEpithet', 'AuthorString', 'GSDNameStatus', 'Sp2000NameStatus', 'IsExtinct', 'HasPreHolocene',
'HasModern', 'LifeZone', 'AdditionalData', 'LTSSpecialist', 'LTSDate','SpeciesURL', 'GSDTaxonGUID', 'GSDNameGUID'
UNION
SELECT
sn.name_code					AS AcceptedTaxonID
,	fam.kingdom					AS Kingdom
,	fam.phylum					AS Phylum
,	fam.class					AS Class
,	fam.`order`					AS `Order`
,	fam.superfamily				AS Superfamily
,	fam.family					AS Family
,	sn.genus					AS Genus
,	sn.subgenus					AS SubGenusName
,	sn.species					AS SpeciesEpithet
,	sn.author					AS AuthorString
,	NULL						AS GSDNameStatus /* ??? */
,	nomstatus.sp2000_status		AS Sp2000NameStatus
,	sn.is_extinct				AS IsExtinct
,	sn.has_preholocene			AS HasPreHolocene
,	sn.has_modern				AS HasModern
,	lz.lifezones				AS LifeZone
,	sn.comment					AS AdditionalData
,	sp.specialist_name			AS LTSSpecialist
,	sn.scrutiny_date			AS LTSDate
,	sn.web_site					AS SpeciesURL
,	sn.GSDTaxonGUID				AS GSDTaxonGUID
,	sn.GSDNameGUID				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/AcceptedSpecies.txt'
FROM scientific_names AS sn
LEFT JOIN families AS fam ON (sn.family_code = fam.family_code OR sn.family_id = fam.record_id)
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_id = sp.record_id)
WHERE (sn.infraspecies_marker IS NULL OR infraspecies_marker = '')
AND sn.is_accepted_name != 0 /* both 1 and 5 are accepted names; 5 likely data corruption */
AND sn.database_id=__DATABASE_ID__;


/* 
 * AcceptedInfraspecificTaxa.txt
 */
SELECT 'AcceptedTaxonID','ParentSpeciesID','InfraSpeciesEpithet','InfraSpeciesMarker','InfraSpeciesAuthorString',
 'GSDNameStatus','Sp2000NameStatus','IsExtinct','HasPreHolocene','HasModern','LifeZone','AdditionalData',
 'LTSSpecialist','LTSDate','InfraSpeciesURL','GSDTaxonGUID','GSDNameGUID'
UNION
SELECT sn.name_code				AS AcceptedTaxonID
,	sn.infraspecies_parent_name_code AS ParentSpeciesID
,	sn.infraspecies				AS InfraSpeciesEpithet
,	sn.infraspecies_marker		AS InfraSpeciesMarker
,	sn.author					AS InfraSpeciesAuthorString
,	NULL						AS GSDNameStatus /* ??? */
,	nomstatus.sp2000_status		AS Sp2000NameStatus
,	sn.is_extinct				AS IsExtinct
,	sn.has_preholocene			AS HasPreHolocene
,	sn.has_modern				AS HasModern
,	lz.lifezones				AS LifeZone
,	sn.comment					AS AdditionalData
,	sp.specialist_name			AS LTSSpecialist
,	sn.scrutiny_date			AS LTSDate
,	sn.web_site					AS InfraSpeciesURL
,	sn.GSDTaxonGUID				AS GSDTaxonGUID
,	sn.GSDNameGUID				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/AcceptedInfraspecificTaxa.txt'
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_id = sp.record_id)
WHERE (sn.infraspecies_marker IS NOT NULL AND infraspecies_marker != '')
AND sn.is_accepted_name != 0
AND sn.database_id=__DATABASE_ID__;


/* 
 * Synonyms.txt
 */
SELECT 'ID','AcceptedTaxonID','Genus','SubGenusName','SpeciesEpithet','AuthorString','InfraSpeciesEpithet',
'InfraSpeciesMarker','InfraSpeciesAuthorString','GSDNameStatus','Sp2000NameStatus','GSDNameGUID'
UNION
SELECT sn.name_code				AS ID
,	sn.accepted_name_code		AS AcceptedTaxonID
,	sn.genus					AS Genus
,	sn.subgenus					AS SubGenusName
,	sn.species					AS SpeciesEpithet
,	IF(sn.infraspecies IS NULL, sn.author, NULL)	AS AuthorString
,	sn.infraspecies				AS InfraSpeciesEpithet
,	sn.infraspecies_marker		AS InfraSpeciesMarker
,	IF(sn.infraspecies IS NULL, NULL, sn.author)    AS InfraSpeciesAuthorString
,	NULL						AS GSDNameStatus /* ??? */
,	nomstatus.sp2000_status		AS Sp2000NameStatus
,	sn.GSDNameGUID				AS GSDNameGUID
INTO OUTFILE '__OUTPUT_DIR__/Synonyms.txt'
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
WHERE sn.is_accepted_name = 0
AND sn.database_id=__DATABASE_ID__;


/*
 * CommonNames.txt
 */
SELECT 'AcceptedTaxonID','CommonName','TransliteratedNames','Language','Country','Area','ReferenceID'
UNION
SELECT sn.name_code				AS AcceptedTaxonID
,	cn.common_name				AS CommonName
,	cn.transliteration			AS TransliteratedNames
,	cn.language					AS Language
,	cn.country					AS Country
,	cn.area						AS Area
,	cn.reference_code			AS ReferenceID
INTO OUTFILE '__OUTPUT_DIR__/CommonNames.txt'
FROM common_names AS cn
LEFT JOIN scientific_names sn ON (cn.name_code = sn.name_code)
WHERE cn.database_id=__DATABASE_ID__;


/*
 * Distribution.txt
 */
SELECT 'AcceptedTaxonID','DistributionElement','StandardInUse','DistributionStatus'
UNION
SELECT d.name_code				AS AcceptedTaxonID
,	d.distribution				AS DistributionElement
,	d.StandardInUse				AS StandardInUse
,	d.DistributionStatus		AS DistributionStatus
INTO OUTFILE '__OUTPUT_DIR__/Distribution.txt'
FROM distribution AS d
WHERE d.database_id=__DATABASE_ID__;


/*
 * References.txt
 */
SELECT 'ReferenceID','Authors','Year','Title','Source'
UNION
SELECT r.reference_code			AS ReferenceID
,	r.author					AS Authors
,	r.year						AS Year
,	r.title						AS Title
,	r.source					AS Source
INTO OUTFILE '__OUTPUT_DIR__/References.txt'
FROM `references` AS r
WHERE r.database_id=__DATABASE_ID__;



/*
 * NameReferences.txt
 */
SELECT 'ID','ReferenceType','ReferenceID'
UNION
SELECT snr.name_code			AS ID
,	snr.reference_type			AS ReferenceType
,	snr.reference_code			AS ReferenceID
INTO OUTFILE '__OUTPUT_DIR__/NameReferences.txt'
FROM scientific_name_references AS snr
WHERE snr.database_id=__DATABASE_ID__;


/*
 * SourceDatabase.txt
 */
SELECT 'DatabaseFullName','DatabaseShortName','DatabaseVersion','ReleaseDate','AuthorsEditors','TaxonomicCoverage',
'GroupNameInEnglish','Abstract','Organization','HomeURL','Coverage','Completeness','Confidence',
'LogoFileName','ContactPerson'
UNION
SELECT db.database_full_name	AS DatabaseFullName
,	db.database_name			AS DatabaseShortName
,	db.version					AS DatabaseVersion
,	db.release_date				AS ReleaseDate
,	db.authors_editors			AS AuthorsEditors
,	db.taxonomic_coverage		AS TaxonomicCoverage
,	NULL						AS GroupNameInEnglish /* ??? */
,	db.abstract					AS Abstract
,	db.organization				AS Organization
,	db.web_site					AS HomeURL
,	db.coverage					AS Coverage
,	db.completeness				AS Completeness
,	db.confidence				AS Confidence
,	NULL						AS LogoFileName
,	db.contact_person			AS ContactPerson
INTO OUTFILE '__OUTPUT_DIR__/SourceDatabase.txt'
FROM `databases` AS db
WHERE db.record_id=__DATABASE_ID__;


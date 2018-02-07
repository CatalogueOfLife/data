DROP TABLE IF EXISTS lifezones_per_name;


CREATE TABLE lifezones_per_name (
  scientific_name_id INT NOT NULL,
  lifezones VARCHAR(255) NULL,
  PRIMARY KEY (scientific_name_id)
);


INSERT INTO lifezones_per_name(scientific_name_id,lifezones)
(SELECT sn.record_id, GROUP_CONCAT(lz.lifezone SEPARATOR '@@@')
FROM scientific_names sn
LEFT JOIN lifezone lz ON (sn.name_code = lz.name_code)
GROUP BY sn.record_id);


/* 
 * AcceptedSpecies.txt
 * Get accepted names at species level
 */
SELECT sn.name_code				AS AcceptedTaxonID
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
FROM scientific_names AS sn
LEFT JOIN families AS fam ON (sn.family_code = fam.family_code OR sn.family_id = fam.record_id)
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_id = sp.record_id)
WHERE (sn.infraspecies_marker IS NULL OR infraspecies_marker = '')
AND sn.is_accepted_name != 0; /* both 1 and 5 are accepted names; 5 likely data corruption */

/* 
 * AcceptedInfraspecificTaxa.txt
 * Get accepted names at infraspecies level
 */
SELECT sn.name_code				AS AcceptedTaxonID
,	sn.infraspecies_parent_name_code AS parentID
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
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
LEFT JOIN lifezones_per_name lz ON (sn.record_id = lz.scientific_name_id)
LEFT JOIN specialists AS sp ON (sn.specialist_id = sp.record_id)
WHERE (sn.infraspecies_marker IS NOT NULL AND infraspecies_marker != '')
AND sn.is_accepted_name != 0;


/* 
 * Synonyms.txt
 */
SELECT sn.name_code				AS ID
,	sn.accepted_name_code		AS AcceptedTaxonID
,	sn.genus					AS Genus
,	sn.subgenus					AS SubGenusName
,	sn.species					AS SpeciesEpithet
,	sn.author					AS AuthorString
,	sn.infraspecies				AS InfraSpeciesEpithet
,	sn.infraspecies_marker		AS InfraSpeciesMarker
,	NULL						AS InfraSpeciesAuthorString /* ??? */
,	NULL						AS GSDNameStatus /* ??? */
,	nomstatus.sp2000_status		AS Sp2000NameStatus
,	sn.GSDNameGUID				AS GSDNameGUID
FROM scientific_names AS sn
LEFT JOIN sp2000_statuses AS nomstatus ON (sn.sp2000_status_id = nomstatus.record_id)
WHERE sn.is_accepted_name = 0;


/*
 * CommonNames.txt
 */
SELECT sn.name_code				AS AcceptedTaxonID
,	cn.common_name				AS CommonName
,	cn.transliteration			AS TransliteratedNames
,	cn.language					AS Language
,	cn.country					AS Country
,	cn.area						AS Area
,	cn.reference_code			AS ReferenceID
FROM common_names AS cn
LEFT JOIN scientific_names sn ON (cn.name_code = sn.name_code);


/*
 * Distribution.txt
 */
SELECT d.name_code				AS AcceptedTaxonID
,	d.distribution				AS DistributionElement
,	d.StandardInUse				AS StandardInUse
,	d.DistributionStatus		AS DistributionStatus
FROM distribution AS d;


/*
 * References.txt
 */
SELECT r.reference_code			AS ReferenceID
,	r.author					AS Authors
,	r.year						AS Year
,	r.title						AS Title
,	r.source					AS Details
FROM `references` AS r;


/*
 * NameReferences.txt
 */
SELECT snr.name_code			AS ID
,	snr.reference_type			AS ReferenceType
,	snr.reference_code			AS ReferenceID
FROM scientific_name_references AS snr;


/*
 * SourceDatabase.txt
 */
SELECT db.database_full_name	AS DatabaseFullName
,	db.database_name			AS DatabaseName
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
FROM `databases` AS db;


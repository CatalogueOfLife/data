SELECT t.record_id AS id
, t.parent_id AS parentNameUsageID
, t.taxon AS taxonRank
, t.name AS scientificName
FROM taxa AS t
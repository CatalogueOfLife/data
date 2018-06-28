SELECT t.taxon_id AS id
, t.parent_id AS parentNameUsageID
, t.rank AS taxonRank
, REPLACE(REPLACE(REPLACE(t.name, '\n', ' '), '\r', ' '), '  ', ' ') AS scientificName
, t.total_species_estimation AS speciesEstimate
, REPLACE(REPLACE(REPLACE(IFNULL(t.estimate_source,''), '\n', ' '), '\r', ' '), '  ', ' ') AS speciesEstimateReference
FROM ac_latest._taxon_tree AS t
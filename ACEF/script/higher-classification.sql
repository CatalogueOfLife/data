SELECT t.taxon_id AS id
, t.parent_id AS parentNameUsageID
, t.rank AS taxonRank
, t.name AS scientificName
, t.total_species_estimation AS speciesEstimate
, IFNULL(t.estimate_source,'') AS speciesEstimateReference
FROM ac_latest._taxon_tree AS t
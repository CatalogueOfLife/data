SELECT t.taxon_id AS id
, IF(t.parent_id = 0, '', t.parent_id) AS parentNameUsageID
, t.rank AS taxonRank
, REPLACE(REPLACE(REPLACE(t.name, '\n', ' '), '\r', ' '), '  ', ' ') AS scientificName
, t.total_species_estimation AS speciesEstimate
, REPLACE(REPLACE(REPLACE(IFNULL(t.estimate_source,''), '\n', ' '), '\r', ' '), '  ', ' ') AS speciesEstimateReference
FROM ac_latest._taxon_tree AS t
WHERE (t.rank IN ('kingdom', 'phylum', 'order', 'class', 'superfamily', 'family'))
/* Exlude rank 'not assigned' for binomial and trinomials - which in practice means: always */
OR (t.rank = 'not assigned' AND INSTR(t.name, ' ') = 0)
ORDER BY (
	CASE t.rank
		WHEN 'kingdom' THEN 0
		WHEN 'phylum' THEN 1
		WHEN 'order' THEN 2
		WHEN 'class' THEN 3
		WHEN 'superfamily' THEN 4
		WHEN 'family' THEN 5
		ELSE /* Shouldn't happen! */ -1
	END
), t.name
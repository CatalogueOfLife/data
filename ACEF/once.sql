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

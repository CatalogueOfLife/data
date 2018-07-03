DROP FUNCTION IF EXISTS N2E;
CREATE FUNCTION N2E(s VARCHAR(2048)) RETURNS VARCHAR(2048) DETERMINISTIC
	RETURN IFNULL(s,'');

DROP FUNCTION IF EXISTS CLEAN_STR;
CREATE FUNCTION CLEAN_STR(s VARCHAR(2048)) RETURNS VARCHAR(2048) DETERMINISTIC
  RETURN REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(N2E(s),'\r',' '),'\n',' '),'\t',' '),'  ',' '),'  ',' '),'  ',' ');

DROP FUNCTION IF EXISTS LOG_MSG;
CREATE FUNCTION LOG_MSG(s VARCHAR(2048)) RETURNS VARCHAR(2048) DETERMINISTIC
	RETURN CONCAT(DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s'), ' ', s);


DROP TABLE IF EXISTS lifezones_per_name;

CREATE TABLE lifezones_per_name (
  scientific_name_id INT NOT NULL,
  lifezones VARCHAR(255) NULL
);


INSERT INTO lifezones_per_name(scientific_name_id,lifezones)
(SELECT sn.record_id, GROUP_CONCAT(lz.lifezone SEPARATOR '@@@')
FROM scientific_names sn
LEFT JOIN lifezone lz ON (sn.name_code = lz.name_code)
GROUP BY sn.record_id);

ALTER TABLE lifezones_per_name ADD PRIMARY KEY(scientific_name_id);


UPDATE dataset SET data_format=1, 
	title = 'GSD ' || (key-1000),
	data_access = 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/' || (key-1000) || '.tar.gz' 
	WHERE key > 999 AND key < 2000;
INSERT INTO dataset (key, title, data_format, data_access) VALUES ('1000', 'CoL Management Classification', 0, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/higher-classification.dwca.zip');
ALTER SEQUENCE dataset_key_seq RESTART WITH 2000;

-- removed, old sources which we mark as deleted
INSERT INTO dataset (key, title, created, deleted) VALUES ('1117', 'chenobase', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1159', 'fada_copepoda', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1135', 'fada_turbellaria', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1165', 'faeu_turbellaria', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1016',  'iopi-gpc', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1043',  'lecypages', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1056',  'lhd', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1064',  'solanaceae_source', now(), now());
INSERT INTO dataset (key, title, created, deleted) VALUES ('1060',  'worms_proseriata-kalyptorhynchia', now(), now());

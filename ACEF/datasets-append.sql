
UPDATE dataset SET data_access = 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/assembly/' || key || '.tar.gz' WHERE key < 1000;
ALTER SEQUENCE dataset_key_seq RESTART WITH 1000;

-- removed, old sources which we mark as deleted
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('117', 'chenobase', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('159', 'fada_copepoda', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('135', 'fada_turbellaria', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('165', 'faeu_turbellaria', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('16',  'iopi-gpc', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('43',  'lecypages', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('56',  'lhd', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('64',  'solanaceae_source', now(), now());
INSERT INTO dataset (data_format, key, title, created, deleted) VALUES ('60',  'worms_proseriata-kalyptorhynchia', now(), now());

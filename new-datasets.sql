-- for enums we use the int ordinal, i.e. array index starting with 0:
-- origin:  http://api.col.plus/vocab/datasetorigin
--          0=EXTERNAL, 1=UPLOADED, 2=MANAGED
-- type:  http://api.col.plus/vocab/datasettype
--          0=nomenclatural, 1=global, 2=regional, 3=personal, 4=other
-- contributes_to:  http://api.col.plus/vocab/catalogue
--          0=COL, 1=PCAT
-- code:  http://api.col.plus/vocab/nomCode
--          0=bacterial, 1=botanical, 2=cultivars, 3=virus, 4=zoological
-- data_format:  http://api.col.plus/vocab/dataformat
--          0=dwca, 1=acef, 2=tcs, 3=coldp

-- use keys from range 1000-1500 for existing GSD IDs+1000
-- or for entirely new datasets in the range of 1600-1699
INSERT INTO dataset (key, origin, type, contributes_to, code, title, import_frequency, data_format, data_access) VALUES 
('1027', 0, 1, 0,    4, 'Scarabs',          1, 1, 'https://github.com/Sp2000/data-scarabs/archive/master.zip'),
('1055', 0, 1, 0,    4, 'Neuropterida',     1, 1, 'https://github.com/Sp2000/data-neuropterida/archive/master.zip'),
('1140', 0, 0, 1,    1, 'WorldFerns',       1, 1, 'https://github.com/Sp2000/data-world-ferns/archive/master.zip'),
('1141', 0, 0, 1,    1, 'WorldPlants',      1, 0, 'https://github.com/Sp2000/data-world-plants/archive/master.zip'),
('1202', 0, 1, 0,    4, 'WoRMS Amphipoda',  1, 1, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/202.tar.gz'),
('1203', 0, 1, 0,    4, 'ThripsWiki',       1, 1, 'https://github.com/Sp2000/data-thrips/archive/master.zip'),
('1600', 0, 1, null, 1, 'ColDP Example',    7, 3, 'https://github.com/Sp2000/coldp/archive/master.zip'),
('1601', 0, 0, 1,    1, 'MycoBank',         7, 0, 'https://github.com/mdoering/mycobank/raw/master/mycobank.zip');

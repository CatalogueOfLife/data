-- for enums we use the int ordinal, i.e. array index starting with 0:
-- origin:  http://api.col.plus/vocab/datasetorigin
--          0=EXTERNAL, 1=UPLOADED, 2=MANAGED
-- type:  http://api.col.plus/vocab/datasettype
--  		0=nomenclatural, 1=global, 2=regional, 3=personal, 4=other
-- contributes_to:  http://api.col.plus/vocab/catalogue
--          0=COL, 1=PCAT
-- code:  http://api.col.plus/vocab/nomCode
--          0=bacterial, 1=botanical, 2=cultivars, 3=virus, 4=zoological
-- data_format:  http://api.col.plus/vocab/dataformat
--          0=dwca, 1=acef, 2=tcs, 3=coldp

-- use keys from range 1600-1699
INSERT INTO dataset (key, origin, type, contributes_to, code, title, import_frequency, data_format, data_access) VALUES 
('1599', 0, 1, null, 1, 'ColDP Example', 7, 3, 'https://github.com/Sp2000/coldp/archive/master.zip'),
('1600', 0, 1, 0, 4, 'Neuropterida', 1, 1, 'https://github.com/Sp2000/colplus-repo/raw/master/various/Neuropterida_ACEF_CoLPlus.zip'),
('1601', 0, 1, 0, 4, 'ThripsWiki', 1, 1, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/203.tar.gz'),
('1602', 0, 1, 0, 4, 'WoRMS Amphipoda', 1, 1, 'https://raw.githubusercontent.com/Sp2000/colplus-repo/master/ACEF/202.tar.gz'),
('1603', 0, 0, 1, 1, 'MycoBank', 7, 0, 'https://github.com/mdoering/mycobank/raw/master/mycobank.zip');

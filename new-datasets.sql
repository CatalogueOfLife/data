-- for enums we use the int ordinal, i.e. array index starting with 0:
-- origin:  http://api.col.plus/vocab/datasetorigin
--          0=EXTERNAL, 1=UPLOADED, 2=MANAGED
-- type:  http://api.col.plus/vocab/datasettype
-- catalogue:  http://api.col.plus/vocab/catalogue
-- code:  http://api.col.plus/vocab/nomCode
-- data_format:  http://api.col.plus/vocab/dataformat
--          0=dwca, 1=acef, 2=tcs, 3=coldp

-- use keys from range 1600-1699
INSERT INTO dataset (key, origin, type, catalogue, code, title, import_frequency, data_format, data_access) VALUES 
('1600', 0, 1, 0, 4, 'Neuropterida', 1, 1, 'https://github.com/Sp2000/colplus-repo/raw/master/various/Neuropterida_ACEF_CoLPlus.zip'),
('1601', 0, 1, 0, 4, 'Thrips Wiki', 1, 1, 'https://github.com/Sp2000/data-thrips/archive/master.zip');

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
-- or for unit tests use 1700-1799
INSERT INTO dataset (key, origin, type, contributes_to, code, title, import_frequency, created_by, modified_by, data_format, data_access, website, description) VALUES 
('1700', 0, 4, null, 4, 'Unit Test: C1 (ACC-ACC species diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C1.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'Searching within the GSD for duplicate accepted names with different author strings'),
('1701', 0, 4, null, 4, 'Unit Test: C2 (ACC-ACC species same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C2.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'Searching within the GSD for duplicate accepted names with identical author strings');

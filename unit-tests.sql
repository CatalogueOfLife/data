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
('1701', 0, 4, null, 4, 'Unit Test: C1  (GSD Duplicates: ACC-ACC species diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C1.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-ACC species (different authors)'),
('1702', 0, 4, null, 4, 'Unit Test: C2  (GSD Duplicates: ACC-ACC species same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C2.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-ACC species (same authors)'),
('1703', 0, 4, null, 4, 'Unit Test: C3  (GSD Duplicates: ACC-ACC infraspecies diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C3.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-ACC infraspecies and infraspecies marker (different authors)'),
('1704', 0, 4, null, 4, 'Unit Test: C4  (GSD Duplicates: ACC-ACC infraspecies same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C4.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-ACC infraspecies and infraspecies marker (same authors)'),
('1705', 0, 4, null, 1, 'Unit Test: C5  (GSD Duplicates: ACC-SYN species diff parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C5.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN species (different parent, different authors)'),
('1706', 0, 4, null, 1, 'Unit Test: C6  (GSD Duplicates: ACC-SYN species diff parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C6.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN species (different parent, same authors)'),
('1707', 0, 4, null, 1, 'Unit Test: C7  (GSD Duplicates: ACC-SYN species same parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C7.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN species (same parent, same authors)'),
('1708', 0, 4, null, 4, 'Unit Test: C8  (GSD Duplicates: ACC-SYN infraspecies diff parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C8.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN infraspecies (different parent, different authors)'),
('1709', 0, 4, null, 1, 'Unit Test: C9  (GSD Duplicates: ACC-SYN infraspecies diff parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C9.zip',  'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN infraspecies (different parent, same authors)'),
('1710', 0, 4, null, 1, 'Unit Test: C10 (GSD Duplicates: ACC-SYN infraspecies same parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C10.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: ACC-SYN infraspecies (same parent, same authors)'),
('1711', 0, 4, null, 1, 'Unit Test: C11 (GSD Duplicates: SYN-SYN species diff parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C11.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN species (different parent, different authors)'),
('1712', 0, 4, null, 1, 'Unit Test: C12 (GSD Duplicates: SYN-SYN species diff parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C12.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN species (different parent, same authors)'),
('1713', 0, 4, null, 1, 'Unit Test: C13 (GSD Duplicates: SYN-SYN species same parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C13.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN species (same parent, different authors)'),
('1714', 0, 4, null, 1, 'Unit Test: C14 (GSD Duplicates: SYN-SYN species same parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C14.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN species (same parent, same authors)'),
('1715', 0, 4, null, 1, 'Unit Test: C15 (GSD Duplicates: SYN-SYN infraspecies diff parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C15.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN infraspecies (different parent, different authors)'),
('1716', 0, 4, null, 1, 'Unit Test: C16 (GSD Duplicates: SYN-SYN infraspecies diff parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C16.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN infraspecies (different parent, same authors)'),
('1717', 0, 4, null, 1, 'Unit Test: C17 (GSD Duplicates: SYN-SYN infraspecies same parent, diff authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C17.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN infraspecies (same parent, different authors)'),
('1718', 0, 4, null, 1, 'Unit Test: C18 (GSD Duplicates: SYN-SYN infraspecies same parent, same authors)',     1, 0, 0, 3, 'https://github.com/Sp2000/data-unit-tests/raw/master/C18.zip', 'https://github.com/Sp2000/colplus-backend/issues/195', 'GSD duplicates: SYN-SYN infraspecies (same parent, same authors)');

# CoL data repository
Repository for CoL ACEF datasets, sectors and decisions exported from the Global Assembly database. 

## ACEF
The ACEF datasets (The CoL Annual Checklist Exchange Format) are all current [CoL datasources](http://www.catalogueoflife.org/col/info/databases) exported directly from the CoL assembly database.
They are therefore already edited and do use modified, prefixed identifiers.

# Sector exports
Straight from Assembly_Globals families and scientific_names tables as the hierarchy codes are not trustworthy.
Exluded are synonyms and infraspecifics for deriving sectors.

Higher taxa which exclusively come from a single GSD are considered sectors.
On (super)family level also sources that exceed 75% of all included species are considered sector sources, even though they
might have included genera from other GSDs (which in turn becomes sectors).

The 4 regional databases IRMNG, ITIS regional, China) are excluded as sector sources as they are too patchy, 
but the classification down to genus level remains in the exported hierarchy.

## requirements
 - MySql server with a `assembly_global` database
 - Postgres 11 server with an empty `colh` database
 - python 3

```
# export assembly global from mysql into parent-child tsv file
rm /tmp/parent_child.tsv
mysql -u root -p assembly_global < parent_child-export.sql

# import into postgres and process the parent child hierarchy
psql -U postgres colh < proc-sectors.sql 
python3 export-sectors.py
```

Then copy the data into the backend sql file:
https://github.com/Sp2000/colplus-backend/blob/master/colplus-dao/src/main/resources/org/col/db/sectors.sql

/Applications/MAMP/Library/bin/mysqldump -u root -p assembly_global parent_child > parent_child.tvs
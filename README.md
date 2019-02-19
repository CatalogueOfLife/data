# Datasource repository for CoL+
Repository for CoL+ datasets in DwC archive or ACEF format. 

## ACEF
The ACEF datasets (The CoL Annual Checklist Exchange Format) are all current [CoL datasources](http://www.catalogueoflife.org/col/info/databases) exported directly from the CoL assembly database.
They are therefore already edited, but compared to the DwC-A files miss generated artefacts like genera.

## DWCA
The DWCA folder contains Darwin Core Archives of the CoL datasources exported via the CoL download service from the CoL production database.


# Col Export
Sql script to export an assembled CoL to a bunch of CSV files matching the old assembly global database structure.

## Usage

 - make sure you have a postgres password file providing access to your database of choice.
 - run the export bash script with optional parameters:
 	- `-h` postgres host, defaults to `localhost`
 	- `-d` database name, defaults to `colplus`
 	- `-o` postgres user, defaults to `col`
 	- `-k` dataset key, defaults to `3` the CoL draft
 	- `-o` ouput directory, defaults to `./ac-export`
 
 ```./ac-export.sh -d colplus -h db.col.plus```



# Sector exports

Straight from Assembly_Globals families and scientific_names tables as the hierarchy codes are not trustworthy.
Exluded are synonyms and infraspecifics for deriving sectors.

Select source that has >90% of all included taxa
Exclude IRMNG & regional dbs which are special


```
psql -U postgres colplus < proc-sectors.sql 
python3 export-sectors.py
```

Then copy the data into the backend sql file:
https://github.com/Sp2000/colplus-backend/blob/master/colplus-dao/src/main/resources/org/col/db/sectors.sql


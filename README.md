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
 	- `-k` dataset key, defaults to `3` the CoL draft
 	- `-o` ouput directory, defaults to `./ac-export`
 
 ```./ac-export.sh -d colplus -h db.col.plus```

#!/bin/bash

host=localhost
db=colplus
user=col
dataset_key=3
export_dir="$(pwd)/ac-export" 

while getopts ":d:h:k:o:u:" opt; do
  case $opt in
    d) db="$OPTARG"
    ;;
    h) host="$OPTARG"
    ;;
    k) dataset_key="$OPTARG"
    ;;
    o) export_dir="$OPTARG"
    ;;
    u) user="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo -e "Create & wipe export director $export_dir\n"
rm -rf $export_dir
mkdir $export_dir
chmod 766 $export_dir

# export csv files
echo -e "Export CoL $dataset_key from $host/$db to CSV files in $export_dir\n"
cat ac-export.sql | sed "s/{{datasetKey}}/${dataset_key}/g; s:{{dir}}:${export_dir}:g" | psql -h $host -U $user $db


# compress
zipfile="${export_dir}/ac-export.zip"
echo -e "Compress CSV files into $zipfile\n"
tar czf $zipfile $export_dir/*.csv

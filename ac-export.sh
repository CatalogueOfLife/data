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

echo -e "\n\n*****\nCreate & wipe export directory $export_dir"
rm -rf $export_dir
mkdir $export_dir
chmod 777 $export_dir

# export csv files
echo -e "\n\n*****\nExport CoL $dataset_key from $host/$db to CSV files in $export_dir\n\n"
cat ac-export.sql | sed "s/{{datasetKey}}/${dataset_key}/g; s:{{dir}}:${export_dir}:g" | psql -h $host -U $user $db


# compress
zipfile="${export_dir}/ac-export.zip"
echo -e "\n\n*****\nCompress CSV files into $zipfile"
zip -j $zipfile $export_dir/*.csv

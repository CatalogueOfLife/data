#!/bin/bash

my_dir=$(pwd)

rm -rf /tmp/acef
mkdir /tmp/acef
if [ ${?} != 0 ]
then
	echo "Could not create temp directory /tmp/acef"
	exit 1
fi

database_id="${1}"

if [ "x${database_id}" = "x" ]
then
	echo "$(date '+%Y-%m-%d %H:%M:%S') Retrieving GSD IDs ..."
	mysql --defaults-extra-file=my.cnf -e 'SELECT record_id FROM `databases`' > /tmp/acef/database_ids.txt
	echo "$(date '+%Y-%m-%d %H:%M:%S') Creating temp table ..."
	mysql --defaults-extra-file=my.cnf < once.sql
else
	echo $database_id > /tmp/acef/database_ids.txt
fi

dsql=${my_dir}/datasets-new.sql
echo "" > ${dsql}
while read -r line
do
	if [ "${line}" = "record_id" ]
	then
		# Skip header
		continue
	fi
    echo "$(date '+%Y-%m-%d %H:%M:%S') Processing database: ${line}"
	mkdir /tmp/acef/${line}
	chmod -R 777 /tmp/acef/${line}
    sed "s/__OUTPUT_DIR__/\/tmp\/acef\/${line}/g" assembly_db_to_acef.sql > /tmp/acef/temp.sql
    sed -i "s/__DATABASE_ID__/${line}/g" /tmp/acef/temp.sql 
    mysql --defaults-extra-file=my.cnf < /tmp/acef/temp.sql
    cd "/tmp/acef/${line}"
    zip_file="/tmp/acef/${line}.tar.gz"
    tar czf ${zip_file} *.txt
    cd ${my_dir}
    mv ${zip_file} ${my_dir}/assembly
    echo "INSERT INTO dataset (data_format, key, title) VALUES (2, ${line}, '${line}');" >> ${dsql}
done < /tmp/acef/database_ids.txt
cat datasets-append.sql >> ${dsql}

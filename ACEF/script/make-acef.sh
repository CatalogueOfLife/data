#!/bin/bash

my_dir=$(pwd)
acef_dir=$(cd ../ && pwd)
ids_file="$my_dir/database_ids.txt"

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
	echo "$(date '+%Y-%m-%d %H:%M:%S') Retrieving GSD IDs"
	mysql --defaults-extra-file=my.cnf -e 'SELECT record_id FROM `databases`' > $ids_file
	echo "$(date '+%Y-%m-%d %H:%M:%S') Executing one-off SQL"
	mysql --defaults-extra-file=my.cnf < once.sql
	echo "$(date '+%Y-%m-%d %H:%M:%S') Clearing directory ${acef_dir}"
	rm -rf "${acef_dir}/*.gz"
else
	echo $database_id > $ids_file
fi

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
    cp "${my_dir}/../logos/${line}.png" "/tmp/acef/${line}/logo.png"
    cd "/tmp/acef/${line}"
    echo -e '0a\n"ID","ReferenceType","ReferenceID"\n.\nw' | ed -s NameReferences.txt
    zip_file="/tmp/acef/${line}.tar.gz"
    tar czf ${zip_file} *.txt
    mv ${zip_file} ${acef_dir}
    cd ${my_dir}
done < $ids_file


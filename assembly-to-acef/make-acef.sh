#!/bin/bash

db_user=col
db_password=col
db_name=Assembly_Global

rm -rf /tmp/acef
mkdir /tmp/acef


database_id="${1}"

if [ "x${database_id}" = "x" ]
then
	mysql --user=${db_user} --password=${db_password} ${db_name} -e 'SELECT record_id AS `FOO` from `databases`' > /tmp/acef/database_ids.txt
else
	echo $database_id > /tmp/acef/database_ids.txt
fi

while read -r line || [[ -n "$line" ]]
do
	if [ "$line" = FOO ]
	then
		continue
	fi
    echo "Processing database: $line"
	mkdir /tmp/acef/$line
	chmod -R 777 /tmp/acef/$line
    sed "s/__OUTPUT_DIR__/\/tmp\/acef\/$line/g" assembly_db_to_acef.sql > /tmp/acef/temp.sql
    sed -i "s/__DATABASE_ID__/$line/g" /tmp/acef/temp.sql 
    mysql --user=${db_user} --password=${db_password} ${db_name} < /tmp/acef/temp.sql
    cd "/tmp/acef/$line"
    tar czf "/tmp/acef/$line.tar.gz" *.txt
done < /tmp/acef/database_ids.txt

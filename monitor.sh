#!/bin/bash

. ../dbConnCD.sh

results=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT ip FROM hotspot;")

for i in $results; do
	ping -c 4 $i > /dev/null
	if [ $? = 1 ]; then
		offline=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT descricao FROM hotspot WHERE ip='$i';")
		echo $offline "-" $i " - OFFLINE em  $(date)" >> monitor.log
		echo "================================================================================"
	else
		online=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT descricao FROM hotspot WHERE ip='$i';")
		echo $online "-" $i " ONLINE em  $(date)"
	fi
done

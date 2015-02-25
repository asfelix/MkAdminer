#!/bin/bash

. ../dbConnCD.sh

# Backup of terminal setup
bkpterminal=`stty -g`

echo "Type your user:"
read usuario
export usuario=$usuario

echo "Enter your password"
# Disable the display of characteres for security reasons
stty -echo intr '^a'
read passwd
export senha=$passwd

# Restore the previously terminal setup
stty $bkpterminal

export porta=64322

results=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT ip FROM hotspot;")

for i in $results; do
	ping -c 1 $i > /dev/null
	if [ $? = 1 ]; then
		echo "$i OFFLINE em $(date)" 
	else
		echo "$i ONLINE em $(date)" 

		# Print user list
		# sshpass -p $senha ssh $usuario@$i -p $porta /user print ;

		# Print information about the RB
		# sshpass -p $senha ssh $usuario@$i -p $porta /system resource print
		sshpass -p $senha ssh $usuario@$i -p $porta /system identity print ;


		# Send update file ans reboot
		# sshpass -p $senha scp -P $porta ~/Downloads/Mikrotik/4xx-7xx/routeros-mipsbe-6.27.npk $usuario@$i:/
		# sshpass -p $senha ssh $usuario@$i -p $porta /system reboot ;


	fi
done

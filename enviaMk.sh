#!/bin/bash

. ../dbConnCD.sh

# Backup of terminal setup
bkpterminal=`stty -g`

echo "Type your login'"
read user
export user=$user

echo "Type your password"
# Disable the display of characteres for security reasons
stty -echo intr '^a'
read passwd
export pass=$passwd

# Restore the previously terminal setup
stty $bkpterminal

export port=64322

results=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT ip FROM hotspot;")

for i in $results; do
	ping -c 1 $i > /dev/null
	if [ $? = 1 ]; then
		echo "$i OFFLINE in $(date)" 
	else
		echo "$i ONLINE in $(date)" 

		# Print user list
		# sshpass -p $pass ssh $user@$i -p $port /user print ;

		# Print information about the RB
		# sshpass -p $pass ssh $user@$i -p $port /system resource print
		sshpass -p $pass ssh $user@$i -p $port /system identity print ;


		# Send update file ans reboot
		# sshpass -p $pass scp -P $port ~/Downloads/Mikrotik/4xx-7xx/routeros-mipsbe-6.27.npk $user@$i:/
		# sshpass -p $pass ssh $user@$i -p $port /system reboot ;



	fi
done

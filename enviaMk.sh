#!/bin/bash

source ../dbConnCD.sh

# Fazemos um backup das configurações atuais de nosso terminal
bkpterminal=`stty -g`

# De modo interativo, pega informações de login e senha
# para acessar as RouterBoards
echo "Digite seu login para as RB's'"
read usuario
export usuario=$usuario

echo "Digite sua senha das RB's"
# Desativa a saída de caracteres no monitor
# para que outras pessoas não vejam qual sua senha
stty -echo intr '^a'
read passwd
export senha=$passwd

# Volta a configuração de terminal previamente salva
stty $bkpterminal

# Defina qual a porta de conexão que o seu servidor SSH escuta
# por questões de segurança é recomendável sempre alterar a porta padrão 22
# para alguma outra de sua preferência que esteja livre
export porta=64322

results=$(mysql --host="$dbhost" --user="$user" --password="$password" --database="$database" --skip-column-names --execute="SELECT ip FROM hotspot;")

for i in $results; do
	ping -c 1 $i > /dev/null
	if [ $? = 1 ]; then
		echo "$i OFFLINE em $(date)" 
	else
		echo "$i ONLINE em $(date)" 

		# Imprime lista de usuários
		# sshpass -p $senha ssh $usuario@$i -p $porta /user print ;

		# Imprime informações sobre RB
		# sshpass -p $senha ssh $usuario@$i -p $porta /system resource print
		sshpass -p $senha ssh $usuario@$i -p $porta /system identity print ;


		# Envia arquivo de atualização e reinicia a RB
		# sshpass -p $senha scp -P $porta ~/Downloads/Mikrotik/4xx-7xx/routeros-mipsbe-6.27.npk $usuario@$i:/
		# sshpass -p $senha ssh $usuario@$i -p $porta /system reboot ;


	fi
done

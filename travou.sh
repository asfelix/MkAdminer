#!/bin/bash
# travou.sh v: 1.a
# Mata processos a partir de um nome de programa fornecido pelo usuário
# Copyright (C) 2013 Alexsandro Felix <felix@ffelix.eti.br>
# http://blog.ffelix.eti.br
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

clear

printf "Que *#@! travou?\n"
read var
clear
pid=`ps  aux |grep $var |grep -v grep |awk '{print $2}'`

if [ -z "$pid" ]; then
	printf "O programa $var não está sendo executado\n"
else
	kill -9 $pid
	printf "Processo(s) encerrado(s):\n$pid\n"
	printf "Programa: $var\n"
fi

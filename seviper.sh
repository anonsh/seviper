#!/bin/bash
echo ""
echo "  .▄▄ · ▄▄▄ . ▌ ▐·▪   ▄▄▄·▄▄▄ .▄▄▄"
echo "  ▐█ ▀. ▀▄.▀·▪█·█▌██ ▐█ ▄█▀▄.▀·█  █·"
echo " ▄ ▀▀▀█▄▐▀▀ ▄▐█▐█•▐█·██▀· ▐▀▀▪ █▀▀▄"
echo " ▐█▄▪ ▐█▐█▄▄▌ ███ ▐█▌▐█▪·•▐█▄▄▌▐• █▌"
echo "   ▀▀▀▀  ▀▀▀ . ▀  ▀▀▀.▀    ▀▀▀.▀  ▀"
echo ""
echo " ● Script modified by Anonshadow"
echo " ● github.com/anonsh"
echo ""
tput setaf 3 ; tput bold ; echo "" ; echo " Seviper will do:" ; echo ""
echo " ● Install and configure the squid proxy on ports 80, 3128, 8080 and 8799."
echo " ● Configure OpenSSH to run on ports 22 and 443."
echo " ● Install a set of scripts and system commands for user management." ; tput sgr0
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p " Press any key to continue..." ; echo "" ; echo "" ; tput sgr0
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Para continuar confirme la IP de este servidor: " -e -i $IP ipdovps
if [ -z "$ipdovps" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "" ; echo " No ha introducido la dirección IP de este servidor. Inténtalo de nuevo. " ; echo "" ; echo "" ; tput sgr0
	exit 1
fi
if [ -f "/root/usuarios.db" ]
then
tput setaf 6 ; tput bold ;	echo ""
	echo "Se encontró una base de datos de usuario ('usuarios.db')!"
	echo "¿Quieres mantenerlo (preservando el límite de conexiones simultáneas de los usuarios)"
	echo "o crear una nueva base de datos?"
	tput setaf 6 ; tput bold ;	echo ""
	echo "[1] Mantener la base de datos actual"
	echo "[2] Crear una nueva base de datos"
	echo "" ; tput sgr0
	read -p "Opção?: " -e -i 1 optiondb
else
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
echo ""
read -p "¿Quieres instalar BadVPN (desbloquea llamadas por WhatsApp)? [s/n]) " -e -i n badvpn
read -p "¿Quieres activar la compresión de SSH (puede aumentar el consumo de memoria RAM)? [s/n]) " -e -i n sshcompression
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Espere a que la configuración automática" ; echo "" ; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/ajuda > /dev/null
rm /root/ExpCleaner.sh /root/CriarUsuario.sh /root/sshlimiter.sh > /dev/null
apt-get install squid3 bc screen nano unzip dos2unix wget -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/alterarcontrasena.sh -O /bin/alterarcontrasena
	chmod +x /bin/alterarcontrasena
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/socks.sh -O /bin/socked
	chmod +x /bin/socked
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/shadowsocks.sh -O /bin/shadowsocks
	chmod +x /bin/shadowsocks
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/ayuda.sh -O /bin/ayuda
	chmod +x /bin/ayuda
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/squid.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget https://raw.githubusercontent.com/anonsh/seviper/master/configs/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/2/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/alterarcontrasena.sh -O /bin/alterarcontrasena
	chmod +x /bin/alterarcontrasena
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/2/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/ayuda.sh -O /bin/ayuda
	chmod +x /bin/ayuda
	wget https://raw.githubusercontent.com/anonsh/seviper/master/scripts/1/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid restart > /dev/null
	else
		/etc/init.d/squid restart > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh restart > /dev/null
	else
		/etc/init.d/ssh restart > /dev/null
	fi
fi
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$badvpn" = 's' ]]; then
	wget https://raw.githubusercontent.com/anonsh/seviper/master/addons/badvpn/badvpnsetup.sh
	chmod +x badvpnsetup.sh
	./badvpnsetup.sh
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Proxy squid instalado y en ejecución en los puertos: 80, 3128, 8080 y 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "OpenSSH se ejecuta en los puertos 22 y 443" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "scripts para la gestión de usuarios instalados" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Lea la documentación para evitar preguntas y problemas!" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Para ver los comandos disponibles, usar el comando: ayuda" ; tput sgr0
echo ""
exit 1

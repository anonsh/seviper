#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN Setup 0.9 by Phreaker56" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN ya ha sido instalado."
	echo "Para ejecutar, crear una sesión en screen"
	echo "Y ejecute el comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "Y deje la sesión de screen ejecutando en segundo plano."
	echo ""
	echo "Ejemplo: screen badudp"
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo "Este es un script que compila e instala automáticamente el programa"
echo "BadVPN en los servidores Debian y Ubuntu para habilitar el enrutamiento UDP"
echo "en el puerto 7300, usado por programas como HTTP Injector."
echo "Permitiendo así la utilización del protocolo UDP para juegos online,"
echo "llamadas VoIP y otras cosas interesantes."
echo "" ; tput sgr0
read -p "Desea continuar? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "La instalación puede demorar bastante, sea paciente..."
	sleep 3
	apt-get install gcc build-essential g++ make -y
	wget https://raw.githubusercontent.com/anonsh/seviper/master/addons/badvpn/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://raw.githubusercontent.com/anonsh/seviper/master/addons/badvpn/badvpn-1.999.128.tar.bz2
	tar xf badvpn-1.999.128.tar.bz2
	cd bad*
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 512 --max-connections-for-client 8" > /bin/badudp
	chmod +x /bin/badudp
	clear
	screen -d -m -S badvpn badudp
	wget https://raw.githubusercontent.com/anonsh/seviper/master/addons/badvpn/badrun.sh
	chmod +x badrun.sh
	echo ""
	echo "BadVPN instalado y corriendo con éxito."
	echo "Cada que se reinicie el servidor, ejecuta: ./badrun.sh"
	echo "para reactivar BadVPN."
	echo ""
	exit
else
	echo ""
	exit
fi
fi

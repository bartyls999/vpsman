
#! / bin / bash
tput setaf 7; tput setab 4; tput bold; printf '% 35s% s% -20s \ n' "VPS Manager 2.0.1"; tput sgr0
tput setaf 3; tput bold; echo ""; echo "This script will:"; echo ""
echo "● Install and configure the squid proxy on ports 80, 3128, 8080 and 8799"; echo "to allow SSH connections to this server"
echo "● Configure OpenSSH to run on ports 22 and 443"
echo "● Install a set of scripts as system commands for user management"; tput sgr0
echo ""
tput setaf 3; tput bold; read -n 1 -s -p "Press any key to continue ..."; echo ""; echo ""; tput sgr0
tput setaf 2; tput bold; echo "Terms of Use"; tput sgr0
echo ""
echo "By using 'VPS Manager 2.0' you agree to the following terms of use:"
echo ""
echo "1. You can:"
echo "a. Install and use 'VPS Manager 2.0' on your server (s)."
echo "b. Create, manage and remove an unlimited number of users through this set of scripts."
echo ""
tput setaf 3; tput bold; read -n 1 -s -p "Press any key to continue ..."; echo ""; echo ""; tput sgr0
echo "2. You cannot:"
echo "a. Edit, modify, share or redistribute (free or commercially)"
echo "this set of scripts without developer permission."
echo "b. Modify or edit the script set to make you look like the developer of the scripts."
echo ""
echo "3. Do you accept that:"
echo "a. The amount paid for this set of scripts does not include warranties or additional support,"
echo "but the user may, on a promotional and non-mandatory basis, for a limited time,"
echo "receive support and help with troubleshooting as long as you respect the terms of use."
echo "b. The user of this set of scripts is solely responsible for any type of implication"
echo "ethical or legal caused by using this set of scripts for any kind of purpose."
echo ""
tput setaf 3; tput bold; read -n 1 -s -p "Press any key to continue ..."; echo ""; echo ""; tput sgr0
echo "4. You agree that the developer will not be responsible for:"
echo "a. Problems caused by using scripts distributed without authorization."
echo "b. Problems caused by conflicts between this set of scripts and other developers' scripts."
echo "c. Problems caused by unauthorized editing or modifying the script code."
echo "d. System problems caused by third-party programs or user modifications / experiments."
echo "e. Problems caused by changes to the server system."
echo "f. Problems caused by the user not following instructions in the script set documentation."
echo "g. Problems that occurred while using scripts to make commercial profit."
echo "h. Problems that may occur when using the script set on systems that are not on the tested systems list."
echo ""
tput setaf 3; tput bold; read -n 1 -s -p "Press any key to continue ..."; echo ""; echo ""; tput sgr0
IP = $ (wget -qO- ipv4.icanhazip.com)
read -p "To continue confirm the IP of this server:" -e -i $ IP ipdovps
if [-z "$ ipdovps"]
then
tput setaf 7; tput setab 1; tput bold; echo ""; echo ""; echo "You did not enter the IP for this server. Please try again."; echo ""; echo ""; tput sgr0
exit 1
fi
if [-f "/root/usuarios.db"]
then
tput setaf 6; tput bold; echo ""
echo "A user database ('users.db') was found!"
echo "Do you want to keep it (preserving the limit of users' simultaneous connections)"
echo "or create a new database?"
tput setaf 6; tput bold; echo ""
echo "[1] Maintain Current Database"
echo "[2] Create a New Database"
echo ""; tput sgr0
read -p "Option ?:" -e -i 1 optiondb
else
awk -F: '$ 3> = 500 {print $ 1 "1"}' / etc / passwd | grep -v '^ nobody'> /root/usuarios.db
fi
echo ""
read -p "Do you want to enable SSH compression (can RAM consumption increase)? [y / n])" -e -i n sshcompression
echo ""
tput setaf 7; tput setab 4; tput bold; echo ""; echo "Wait for automatic configuration"; echo ""; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm / bin / create user / bin / expcleaner / bin / sshlimiter / bin / addhost / bin / list / bin / sshmonitor / bin / help> / dev / null
rm /root/ExpCleaner.sh /root/CreateUser.sh /root/sshlimiter.sh> / dev / null
apt-get install squid3 bc screen nano unzip dos2unix wget -y
killall apache2
apt-get purge apache2 -y
if [-f "/ usr / sbin / ufw"]; then
ufw allow 443 / tcp; ufw allow 80 / tcp; ufw allow 3128 / tcp; ufw allow 8799 / tcp; ufw allow 8080 / tcp
fi
if [-d "/ etc / squid3 /"]
then
wget http://phreaker56.obex.pw/vpsmanager/squid1.txt -O / tmp / sqd1
echo "acl url3 dstdomain -i $ ipdovps"> / tmp / sqd2
wget http://phreaker56.obex.pw/vpsmanager/squid2.txt -O / tmp / sqd3
cat / tmp / sqd1 / tmp / sqd2 / tmp / sqd3> /etc/squid3/squid.conf
wget http://phreaker56.obex.pw/vpsmanager/payload.txt -O /etc/squid3/payload.txt
echo "" >> /etc/squid3/payload.txt
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://phreaker56.obex.pw/vpsmanager/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://phreaker56.obex.pw/vpsmanager/scripts/alterarsenha.sh -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget http://phreaker56.obex.pw/vpsmanager/scripts/criarusuario2.sh -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget http://phreaker56.obex.pw/vpsmanager/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://phreaker56.obex.pw/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://phreaker56.obex.pw/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://phreaker56.obex.pw/vpsmanager/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://phreaker56.obex.pw/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://phreaker56.obex.pw/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget http://phreaker56.obex.pw/vpsmanager/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://phreaker56.obex.pw/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
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
	wget http://phreaker56.obex.pw/vpsmanager/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://phreaker56.obex.pw/vpsmanager/squid.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget http://phreaker56.obex.pw/vpsmanager/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://phreaker56.obex.pw/vpsmanager/scripts/2/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://phreaker56.obex.pw/vpsmanager/scripts/alterarsenha.sh -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget http://phreaker56.obex.pw/vpsmanager/scripts/criarusuario2.sh -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget http://phreaker56.obex.pw/vpsmanager/scripts/2/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://phreaker56.obex.pw/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://phreaker56.obex.pw/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://phreaker56.obex.pw/vpsmanager/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://phreaker56.obex.pw/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://phreaker56.obex.pw/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget http://phreaker56.obex.pw/vpsmanager/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://phreaker56.obex.pw/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid reload > /dev/null
	else
		/etc/init.d/squid reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Squid Proxy Installed and running on the ports: 80, 3128, 8080 and 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "OpenSSH running on ports 22 and 443" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Scripts for user management installed" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Read the documentation to avoid questions and problems!" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "To see the available commands use the command: help" ; tput sgr0
echo ""
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
exit 1
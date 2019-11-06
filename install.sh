#!/bin/sh

px_choose_shell () {

	SHELL_OK=`cat /etc/shells | sed -e '/^#/d' | sed -e '/^$/d'`
	echo "Your current shell: $SHELL"

	select var in $SHELL_OK
	do
		if [ "$var" ]
		then
			echo "You choose $var"
			break
		fi
	done

}

cat <<-EOF


 ██▓███   ██▓ ███▄ ▄███▓ ██▓███     ▒██   ██▒
▓██░  ██▒▓██▒▓██▒▀█▀ ██▒▓██░  ██▒   ▒▒ █ █ ▒░
▓██░ ██▓▒▒██▒▓██    ▓██░▓██░ ██▓▒   ░░  █   ░
▒██▄█▓▒ ▒░██░▒██    ▒██ ▒██▄█▓▒ ▒    ░ █ █ ▒
▒██▒ ░  ░░██░▒██▒   ░██▒▒██▒ ░  ░   ▒██▒ ▒██▒
▒▓▒░ ░  ░░▓  ░ ▒░   ░  ░▒▓▒░ ░  ░   ▒▒ ░ ░▓ ░
░▒ ░      ▒ ░░  ░      ░░▒ ░        ░░   ░▒ ░
░░        ▒ ░░      ░   ░░           ░    ░
	  ░         ░                ░    ░

EOF

px_choose_shell

echo "PimpX: Installation ended"

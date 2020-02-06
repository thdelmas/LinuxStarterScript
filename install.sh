#!/bin/bash 

##################################################################
#Script Name	: pimpx.sh
#Description	: 
#Args          	:
#Author       	: Thdelmas
#Email         	: thedelleg@gmail.com
###################################################################

PIMPX_VERSION=1.0.0

pimpx_hello () {
	cat <<-EOF

██████╗ ██╗███╗   ███╗██████╗     ██╗  ██╗
██╔══██╗██║████╗ ████║██╔══██╗    ╚██╗██╔╝
██████╔╝██║██╔████╔██║██████╔╝     ╚███╔╝ 
██╔═══╝ ██║██║╚██╔╝██║██╔═══╝      ██╔██╗ 
██║     ██║██║ ╚═╝ ██║██║         ██╔╝ ██╗
╚═╝     ╚═╝╚═╝     ╚═╝╚═╝         ╚═╝  ╚═╝

EOF
}

pimpx_whereis() {
	if [ "$XDG_CONFIG_HOME" -a -w "$XDG_CONFIG_HOME" -a -r "$XDG_CONFIG_HOME" ]
	then
		export PIMPX="$XDG_CONFIG_HOME/pimpx"
	elif [ "$HOME" -a -w "$HOME/.config" -a -r "$HOME/.config" ]
	then
		export PIMPX="$HOME/.config/pimpx"
	elif [ -w '/etc' -a -r '/etc' ]
	then
		export PIMPX='/etc/pimpx'
	elif [ "$HOME" -a -w "$HOME" -a -r "$HOME" ]
	then
		export PIMPX="$HOME/.pimpx"
	else
		return 1
	fi
	return 0
}

pimpx_recover() {
	if [ "$PIMPX" ]
	then
		cd "$PIMPX" &&
			rm -rf "$PIMPX/core"
					curl https://gitlab.com/thdelmas/PimpX/-/archive/master/PimpX-master.tar.gz | gunzip | tar -xv && mv "$PIMPX/Pimpx-master" "$PIMPX/core"
	fi
}

pimpx_update() {
	if [ ! -f "$PIMPX/version" ] || [ "$(cat "$PIMPX/version" | sed 's/\.//g')" -lt "$(echo "$PIMPX_VERSION" | sed 's/\.//g')" ]
	then
		echo "Update ? (y/n)"
		read rep
		if [ "$rep" = 'Y' -o "$rep" = 'y' -o "$rep" = 'yes' ]
		then
			echo 'Update . . .'
			pimpx_recover
		fi
	fi
}

pimpx_install() {
	pimpx_hello
	if [ ! "$PIMPX" ]
	then
		if ! pimpx_whereis
		then
			echo 'Failed to install Pimpx'
		else
			echo "Pimpx installation path: $PIMPX"
		fi
	fi
	if [ "$PIMPX" -a ! -d "$PIMPX" ]
	then
		echo 'Install . . .'
		rm -rf "$PIMPX"
		mkdir "$PIMPX"
		cd "$PIMPX"
		mkdir "$PIMPX/functions" "$PIMPX/scripts"
		rm -rf "$PIMPX/core"
		curl https://gitlab.com/thdelmas/PimpX/-/archive/master/PimpX-master.tar.gz | gunzip | tar -xv && mv "$PIMPX/Pimpx-master" "$PIMPX/core"
	elif [ "$PIMPX" -a -d "$PIMPX" ]
	then
		echo 'Pimpx is already installed'
		pimpx_update
	else
		echo 'Pimpx not installed'
	fi
}

pimpx_install

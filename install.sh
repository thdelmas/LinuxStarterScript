git_prompt () {
	OK='\033[32m' ;
	KO='\033[31m' ;
	GIT_STATUS="$( git status | grep 'Your branch is up to date' )" ;
	if [ "$GIT_STATUS" ]
		then
			echo "$OK`git branch -a | cat | grep '\*' | cut -d' ' -f2`" ;
	else
		echo "$KO`git branch -a | cat | grep '\*' | cut -d' ' -f2`" ;
	fi
}

px_set_prompt () {
	RESET='\033[0m'
	export PS1="\u@\h|\w [$?]"
	if [ "$(git status | wc -l)" -eq '4' ]
	then
		export PS1="$PS1(\033[32m`git_prompt`$RESET)\n> "
	else
		export PS1="$PS1(\033[31m`git_prompt`$RESET)\n> "
	fi
}

px_choose_shell () {

	SHELL_OK=`cat /etc/shells | sed -e '/^#/d' | sed -e '/^$/d'` ;
	echo "Your current shell: $SHELL" ;

	select var in $SHELL_OK
		do
			if [ "$var" ]
				then
					echo "You choose $var" ;
		break ;
		fi
			done ;
}

add_cd_path () {
	for i in $@
	do
		if [ ! "$(echo $CDPATH | tr ':' '\n' | grep \'$i'$'\')" ]
		then
			export CDPATH="${CDPATH:+$CDPATH:}$i"
		fi
	done
}

pimpx_set_xdg () {
	if [ ! "$XDG_DATA_HOME" ]
	then
		export XDG_DATA_HOME="$HOME/.local/share"
		mkdir -p "$XDG_DATA_HOME"
		chmod 0700 "$XDG_DATA_HOME"
	fi
	if [ ! "$XDG_CONFIG_HOME" ]
	then
		export XDG_CONFIG_HOME="$HOME/.config"
		mkdir -p "$XDG_CONFIG_HOME"
		chmod 0700 "$XDG_CONFIG_HOME"
	fi
	if [ ! "$XDG_DATA_DIRS" ]
	then
		export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
	fi
	if [ ! "$XDG_CONFIG_DIRS" ]
	then
		export XDG_CONFIG_DIRS="/etc/xdg"
	fi
	if [ ! "$XDG_CACHE_HOME" ]
	then
		export XDG_CACHE_HOME="$HOME/.cache"
		mkdir -p "$XDG_CACHE_HOME"
		chmod 0700 "$XDG_CACHE_HOME"
	fi
}

pimpx_launch () {
	pimpx_set_xdg
}

pimpx_rc () {
	PIMPXRC="$PIMPX/pimpx.rc"
	echo '#- Pimp X Configuration file -#' > "$PIMPXRC"
	echo "PIMPX='$PIMPX'" >> "$PIMPXRC"
	echo '#- Load pimpx functions in pimpx/functions -#' >> "$PIMPXRC"
	echo "for i in \`ls $PIMPX/functions\` ;\n do ;\n source \"$PIMPX/functions/\$i\" ;\n done" >> "$PIMPXRC"
}



pimpx_install () {
	cat <<-EOF


██████╗ ██╗███╗   ███╗██████╗     ██╗  ██╗
██╔══██╗██║████╗ ████║██╔══██╗    ╚██╗██╔╝
██████╔╝██║██╔████╔██║██████╔╝     ╚███╔╝ 
██╔═══╝ ██║██║╚██╔╝██║██╔═══╝      ██╔██╗ 
██║     ██║██║ ╚═╝ ██║██║         ██╔╝ ██╗
╚═╝     ╚═╝╚═╝     ╚═╝╚═╝         ╚═╝  ╚═╝


EOF

echo "Default shell: $SHELL"
pimpx_set_xdg
export PIMPX="$XDG_CONFIG_HOME/pimpx"

if [ -d "$PIMPX" ]
then
	echo "Pimpx already installed :)"
	read -p "Update ? (y/n): " stdin
	if [ "$stdin"  = 'y' ]
	then
		cd "$PIMPX" && git pull && echo "Now up-to-date :)"
	fi
else
	echo "Installing PimpX here: $PIMPX"
	if [ "$(git --version | grep version)" ]
	then 
		git clone https://github.com/thdelmas/pimpx "$PIMPX"
	fi
	pimpx_rc
	echo "PimpX is now installed"
fi


echo "## \/ Pimp X uninstall function \/ ##

pimpx_uninstall () {
	echo 'Good Bye, friend..\n See you soon.'
	rm -rf '$PIMPX'
	echo 'BYBYEE'
}" > "$PIMPX/functions/pimpx_unistall.sh"

}

pimpx_install


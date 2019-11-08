git_prompt () {
	echo `git branch -a | cat | grep '\*' | cut -d' ' -f2`
}

px_set_prompt () {
	RESET='\033[0m'
	export PS1="\u@\h|\w [$?]"
	if [ "$(git status | wc -l)" -eq '4' ]
	then
		export PS1="$PS1\(\033[32m`git_prompt`$RESET\)\n> "
	else
		export PS1="$PS1\(\033[31m`git_prompt`$RESET\)\n> "
	fi
}

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

add_cd_path () {
	for i in $@
	do
		if [ ! "$(echo $CDPATH | tr ':' '\n' | grep \'$i'$'\')" ]
		then
			export CDPATH="${CDPATH:+$CDPATH:}$i"
		fi
	done
}

cat <<-EOF


██████╗ ██╗███╗   ███╗██████╗     ██╗  ██╗
██╔══██╗██║████╗ ████║██╔══██╗    ╚██╗██╔╝
██████╔╝██║██╔████╔██║██████╔╝     ╚███╔╝ 
██╔═══╝ ██║██║╚██╔╝██║██╔═══╝      ██╔██╗ 
██║     ██║██║ ╚═╝ ██║██║         ██╔╝ ██╗
╚═╝     ╚═╝╚═╝     ╚═╝╚═╝         ╚═╝  ╚═╝

                                          
EOF

echo "PimpX: Installation ended"

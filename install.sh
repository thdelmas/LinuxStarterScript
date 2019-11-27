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
	RESET='\033[0m' ;
	export PS1="\u@\h|\w [$?] " ;
	export PS1="$PS1(`git_prompt`)\n> " ;
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

px_set_prompt

echo "PimpX: Installation ended"

take()
{
	if [ -z "$1" ]
	then
		return 1;
	fi
	if [ ! -e "$1" ]
	then
		mkdir "$1";
	elif [ ! -d "$1" ]
	then
		echo "take: $1: not a directory"
		return 1;
	fi
	if [ -e "$1" ] && [ -d "$1" ]
	then
		cd "$1"
		return 0
	fi
	return 1
	}

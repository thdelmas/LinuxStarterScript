
_LSS_git_ps1()
{
				git branch -a 2>&- | grep '^*' | colrm 1 2
		}

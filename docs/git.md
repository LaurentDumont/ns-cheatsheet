##Git Stuff

###easy-git.sh
```
#!/bin/bash
DIRECTORY=.git
if [ -z "$1" ]; then
	echo "You savage, you need a comment for a commit!"
	exit
fi

if [ -d "$DIRECTORY" ]; then
	git add .
	git commit -S -m "$1"
	git push origin master
else
	echo "This is NOT a git repo"
fi
```
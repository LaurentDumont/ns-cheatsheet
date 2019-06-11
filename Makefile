#Change default shell to bas.
#https://stackoverflow.com/questions/7507810/how-to-source-a-script-in-a-makefile
#test4

#SHELL := /bin/bash
SHELL := /usr/bin/fish

deploy-gh-pages:
	#markdown-pdf docs/ccna.md --out pdf/ccna.pdf
	#Source VENV with fish suffix for Fish shell
	#source venv/bin/activate
	#Doesn't seem to work in the fish shell
	source venv/bin/activate.fish  
	git add .
	git commit -m "More Stuff"
	git push origin master
	mkdocs gh-deploy
	git add .
	git commit -m "More Stuff!"
	git push origin master

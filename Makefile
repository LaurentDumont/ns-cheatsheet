#Change default shell to bas.
#https://stackoverflow.com/questions/7507810/how-to-source-a-script-in-a-makefile
#test1

SHELL := /bin/bash

deploy-gh-pages:
	#markdown-pdf docs/ccna.md --out pdf/ccna.pdf
	#Source VENV with fish suffix for Fish shell
	git add .
	git commit -m "More Stuff"
	git push origin master
	/home/ldumont/projects/ns-cheatsheet/venv/bin/mkdocs gh-deploy
	git add .
	git commit -m "More Stuff!"
	git push origin master

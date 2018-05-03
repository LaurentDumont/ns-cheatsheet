deploy-gh-pages:
	git add .
	git commit -m "More Stuff"
	mkdocs gh-deploy
	git add .
	git commit -m "More Stuff"
	git push origin master

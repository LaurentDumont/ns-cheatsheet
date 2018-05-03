deploy-gh-pages:
	git add .
	git commit -m "More Stuff"
	mkdocs gh-deploy
	git push origin master

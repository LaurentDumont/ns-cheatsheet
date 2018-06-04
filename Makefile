deploy-gh-pages:
	#markdown-pdf docs/ccna.md --out pdf/ccna.pdf
	git add .
	git commit -m "More Stuff"
	git push origin master
	mkdocs gh-deploy
	git add .
	git commit -m "More Stuff!"
	git push origin master

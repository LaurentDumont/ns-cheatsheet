#!/usr/bin/fish
source venv/bin/activate.fish  
git add .
git commit -m "More Stuff"
git push origin master
mkdocs gh-deploy
git add .
git commit -m "More Stuff!"
git push origin master

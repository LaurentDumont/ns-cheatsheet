#!/usr/bin/bash
source venv/bin/activate 
git add .
git commit -m "More Stuff"
git push origin master
mkdocs gh-deploy
git add .
git commit -m "More Stuff!"
git push origin master

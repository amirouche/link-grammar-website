all:
	ROOT=https://amirouche.github.io/link-grammar-website/ guile -L . render.scm

dev:
	guile -L . render.scm
	python3 -m http.server

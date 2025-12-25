# Makefile for LaTeX CV
FILENAME = cv

pdf:
	latexmk -pdf -outdir=out -interaction=nonstopmode $(FILENAME).tex

clean:
	latexmk -c
	rm -f *.bbl *.run.xml *.synctex.gz

watch:
	latexmk -pdf -pvc $(FILENAME).tex

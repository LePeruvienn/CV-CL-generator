# LateX Makefile
CV_FILE = cv
LM_FILE = lm
OUT_DIR = out
LATEX_FLAGS = -pdf -outdir=$(OUT_DIR) -interaction=nonstopmode

all: cv lm

test:
	./scripts/make-cl.sh

cv:
	latexmk $(LATEX_FLAGS) $(CV_FILE).tex

lm:
	latexmk $(LATEX_FLAGS) $(LM_FILE).tex

clean:
	latexmk -outdir=$(OUT_DIR) -c
	rm -rf $(OUT_DIR)
	rm -f *.bbl *.run.xml *.synctex.gz *.fdb_latexmk *.fls

watch:
	latexmk -pdf -pvc -outdir=$(OUT_DIR) $(CV_FILE).tex

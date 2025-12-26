# CONSTANTS
CV_FILE = cv
LM_FILE = lm
OUT_DIR = out
LATEX_FLAGS = -pdf -outdir=$(OUT_DIR) -interaction=nonstopmode

# ARGS DEFAULT VALUES
FILENAME ?= NULL
FILEPATH ?= NULL
LANGUAGE ?= english

cl:
	./scripts/make-cl.sh $(FILENAME) $(FILEPATH) $(LANGUAGE)

cv:
	latexmk $(LATEX_FLAGS) $(CV_FILE).tex

clean:
	latexmk -outdir=$(OUT_DIR) -c
	rm -rf $(OUT_DIR)
	rm -f *.bbl *.run.xml *.synctex.gz *.fdb_latexmk *.fls

watch:
	latexmk -pdf -pvc -outdir=$(OUT_DIR) $(CV_FILE).tex

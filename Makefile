# CONSTANTS
CV_FILE = cv
CL_FILE = cl
LM_FILE = lm
OUT_DIR = output
LATEX_FLAGS = -pdf -outdir=$(OUT_DIR) -interaction=nonstopmode

# ARGS DEFAULT VALUES
FILENAME ?= NULL
FILEPATH ?= NULL
LANGUAGE ?= english

cv:
	./scripts/make-cv.sh $(FILENAME) $(FILEPATH) $(LANGUAGE)

cl:
	./scripts/make-cl.sh $(FILENAME) $(FILEPATH) $(LANGUAGE)

build:
	latexmk $(LATEX_FLAGS) $(CL_FILE).tex
	latexmk $(LATEX_FLAGS) $(CV_FILE).tex

watch:
	latexmk -pdf -pvc -outdir=$(OUT_DIR) $(CV_FILE).tex

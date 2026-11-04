# Figures are built out of tree: every PDF lands in `build/`, and nothing
# under `src/` is ever written to. A build must leave `git status` empty.

LATEX     ?= xelatex
LATEXOPTS ?= -interaction=nonstopmode -halt-on-error -file-line-error

SRC     := src/graphics
BUILD   := build
FIGURES := 01-two-phases 02-agent-boundary 03-workspace-provenance 04-case-isolation 05-escape-paths 06-context-leaks

.PHONY: all figures atlas png clean

all: figures atlas

$(BUILD):
	mkdir -p $(BUILD)

# Each figure is a standalone document: one .tex in, one PDF out.
figures: | $(BUILD)
	@set -e; cd $(SRC) && for f in $(FIGURES); do \
	  echo "  $$f"; \
	  $(LATEX) $(LATEXOPTS) -output-directory=../../$(BUILD) \
	    figures/$$f.tex >/dev/null || exit 1; \
	done

# The atlas includes the figure PDFs, so it is built after them, twice
# (it embeds them by reference to a finished page).
atlas: figures
	@cd $(SRC) && for i in 1 2; do \
	  $(LATEX) $(LATEXOPTS) -output-directory=../../$(BUILD) \
	    -jobname=atlas '\def\builddir{$(abspath $(BUILD))/}\input{atlas}' \
	    >/dev/null || exit 1; \
	done; echo "  atlas"

# Previews, for reading the figures without a PDF reader.
png: all
	@for f in $(FIGURES) atlas; do \
	  pdftoppm -r 150 -png -singlefile $(BUILD)/$$f.pdf $(BUILD)/$$f; \
	done

clean:
	rm -rf $(BUILD)

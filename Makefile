PANDOC = pandoc
LATEX = pdflatex
BIBTEX = bibtex

TEXLECTURES=0-introduction.tex \
            1-interpretation.tex \
						2-reflection.tex \
						3-compilation.tex \
						4-dsl.tex \
						5-synthesis.tex \
						6-explore.tex

GENERATED_FILES=$(TEXLECTURES_GENERATED) \
                lecture-notes.aux \
                lecture-notes.bbl \
                lecture-notes.blg \
                lecture-notes.log \
                lecture-notes.out \
                lecture-notes.pdf \
                lecture-notes.toc \
                $(patsubst %.tex,%.aux,$(TEXLECTURES))

.PHONY: all

all: lecture-notes.pdf
	@echo "words:" $$(pdftotext $< - | wc -w)

lecture-notes.tex: $(TEXLECTURES)
lecture-notes.pdf: lecture-notes.tex $(TEXLECTURES) meta.bib
	$(LATEX) $(patsubst %.tex,%,$<)
	$(BIBTEX) $(patsubst %.tex,%,$<)
	$(LATEX) $(patsubst %.tex,%,$<)
	$(LATEX) $(patsubst %.tex,%,$<)

clean:
	rm -f $(GENERATED_FILES)

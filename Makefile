## $* = filename without extension
## $@ = the output file
## $< = the input file

.SUFFIXES: .tex .pdf .Rnw .R

PKG = nclRpredictive
DIR = vignettes

PRACS = practical1 practical2 practical3 practical4 \
	solutions1 solutions2 solutions3 solutions4
SOLS = 
OTHER = 
ALL =  $(PRACS)  $(SOLS) $(OTHER)

SOLSPDF = $(SOLS:=.pdf)
PRACSPDF = $(PRACS:=.pdf)
OTHERPDF = $(OTHER:=.pdf)
ALLPDF = $(ALL:=.pdf)

PRACSRNW =  $(PRACS:=.Rnw)
SOLSRNW =  $(SOLS:=.Rnw)

.PHONY: force sols all clean commit cleaner

force: 
	make -C $(DIR) -f ../Makefile all

all: $(PRACSPDF) $(OTHERPDF)
	cp $(ALLPDF) ../../rcourses.github.io/$(PKG)/

commit: 
	make force
	git commit -a
	git push
	cd ../rcourses.github.io/$(PKG) && git add $(ALLPDF) && \
		git commit -m "Adding nclRpredictive" && git push
	make clean

view: 
	make force
	acroread ../pdfs/*.pdf

build:
	make force
	make cleaner
	cd ../ && R CMD build $(PKG)

check:
	make build
	cd ../ && R CMD check --as-cran $(PKG)_*.tar.gz

install: 
	make build
	cd ../ && R CMD INSTALL $(PKG)_*.tar.gz

.Rnw.pdf:
	Rscript  -e "require(knitr); knit('$*.Rnw', output='$*.tex')"
	pdflatex $*.tex
	pdflatex $*.tex

clean:
	cd $(DIR) && rm -fvr knitr_figure && \
	rm -fv $(ALLPDF)  *.tex *.synctex.gz \
		*.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof \
		 *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb \
		Rplots.pdf example.RData d.csv.gz mygraph.* \
		knitr_* knitr.sty .Rhistory ex.data

cleaner:
	make clean
	cd $(DIR) && rm -fvr auto/
	cd ../ && rm -fvr $(PKG).Rcheck $(PKG)_*.tar.gz


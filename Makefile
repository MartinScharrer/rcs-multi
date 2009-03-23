# $Id: Makefile 628 2007-07-10 20:32:06Z martin $

PACKAGE=rcs-multi
PACKFILES = ${PACKAGE}.dtx ${PACKAGE}.ins ${PACKAGE}.pdf example_main.tex \
			example_chap1.tex example.pdf Makefile README
TEXAUX = *.aux *.log *.glo *.ind *.idx *.out *.svt *.toc *.ilg *.gls *.hd
TESTDIR = tests
TESTS = $(patsubst %.tex,%,$(subst ${TESTDIR}/,,$(wildcard ${TESTDIR}/test?.tex ${TESTDIR}/test??.tex))) # look for all test*.tex file names and remove the '.tex' 
TESTARGS = -output-directory ${TESTDIR}
INSGENERATED = ${PACKAGE}.sty
GENERATED = ${INSGENERATED} ${PACKAGE}.pdf example.pdf ${PACKAGE}.zip ${PACKAGE}.tar.gz ${TESTDIR}/test*.pdf
ZIPFILE = ${PACKAGE}-${ZIPVERSION}.zip

LATEX_OPTIONS = -interaction=batchmode
LATEX = pdflatex ${LATEX_OPTIONS}

RED   = \033[01;31m
GREEN = \033[01;32m
WHITE = \033[00m

.PHONY: all doc package clean fullclean example testclean ${TESTS}

all: package doc example
new: fullclean all

doc: ${PACKAGE}.pdf 

package: ${PACKAGE}.sty

%.pdf: %.dtx
	${LATEX} $*.dtx
	${LATEX} $*.dtx
	-makeindex -s gind.ist -o $*.ind $*.idx
	-makeindex -s gglo.ist -o $*.gls $*.glo
	${LATEX} $*.dtx
	${LATEX} $*.dtx

%.pdf: %.eps
	epstopdf $<

%.eps: %.dia
	dia -t eps -e $@ $<

${PACKAGE}.pdf:

${INSGENERATED}: *.dtx ${PACKAGE}.ins 
	yes | latex ${PACKAGE}.ins

clean:
	rm -f ${TEXAUX} $(addprefix ${TESTDIR}/, ${TEXAUX})

fullclean:
	rm -f ${TEXAUX} $(addprefix ${TESTDIR}/, ${TEXAUX}) ${GENERATED} *~ *.backup

example: example.pdf

example.pdf: example_main.tex example_chap1.tex ${PACKAGE}.sty
	${LATEX} $<
	${LATEX} $<
	mv example_main.pdf $@

zip: fullclean package doc example tests ${ZIPFILE}
${PACKAGE}.zip: zip

zip: ZIPVERSION=$(shell grep '\\def\\fileversion{.*}' ${PACKAGE}.dtx | sed -e 's/\\def\\fileversion{\(.*\)}/\1/' -e 's/\s\+//g')

${ZIPFILE}: ${PACKFILES}
	grep -q '\* Checksum passed \*' ${PACKAGE}.log
	-pdfopt ${PACKAGE}.pdf opt_${PACKAGE}.pdf && mv opt_${PACKAGE}.pdf ${PACKAGE}.pdf
	zip ${ZIPFILE} ${PACKFILES}
	@echo
	@echo "ZIP file ${ZIPFILE} created!"

tar.gz: ${PACKAGE}.tar.gz

${PACKAGE}.tar.gz:
	tar -czf $@ ${PACKFILES}

# Make sure TeX finds the input files in TESTDIR
tests ${TESTS}: export TEXINPUTS:=${TEXINPUTS}:${TESTDIR}
tests ${TESTS}: LATEX_OPTIONS=

testclean:
	@${RM} $(foreach ext, aux log out pdf, tests/test*.${ext})

tests: package testclean
	@echo "Running tests: ${TESTS}:"
	@${MAKE} -e -i --no-print-directory ${TESTS} \
		TESTARGS="-interaction=batchmode -output-directory=${TESTDIR}"\
		TESTPLOPT="-q"\
		> /dev/null

${TESTS}: % : ${TESTDIR}/%.tex package testclean
	@-${LATEX} -interaction=nonstopmode ${TESTARGS} $< 1>/dev/null 2>/dev/null
	@if (${LATEX} ${TESTARGS} $< && (test ! -e ${TESTDIR}/$*.pl || ${TESTDIR}/$*.pl ${TESTPLOPT})); \
		then /bin/echo -e "${GREEN}$@ succeeded${WHITE}" >&2; \
		else /bin/echo -e "${RED}$@ failed!!!!!!${WHITE}" >&2; fi



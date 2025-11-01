TEXI_DIR    := doc
TEXI        := $(TEXI_DIR)/gams-mode.texi
INFO        := $(TEXI:.texi=.info)
REFCARD_TEX := $(TEXI_DIR)/refcard-gams.tex
REFCARD_PDF := $(REFCARD_TEX:.tex=.pdf)

.PHONY: all info refcard clean distclean

all: info

info: $(INFO)

refcard: $(REFCARD_PDF)

$(TEXI_DIR)/%.info: $(TEXI_DIR)/%.texi
	makeinfo --output=$@ $<

$(REFCARD_PDF): $(REFCARD_TEX)
	latexmk -pdf -quiet -f -outdir=$(TEXI_DIR) $(REFCARD_TEX)

clean:
	rm -f $(INFO) \
	      $(TEXI_DIR)/gams-mode.aux \
	      $(TEXI_DIR)/gams-mode.cp \
	      $(TEXI_DIR)/gams-mode.fn \
	      $(TEXI_DIR)/gams-mode.ky \
	      $(TEXI_DIR)/gams-mode.log \
	      $(TEXI_DIR)/gams-mode.pg \
	      $(TEXI_DIR)/gams-mode.toc \
	      $(TEXI_DIR)/gams-mode.tp \
	      $(TEXI_DIR)/gams-mode.vr
	latexmk -C -outdir=$(TEXI_DIR) $(REFCARD_TEX) >/dev/null 2>&1 || true

distclean: clean

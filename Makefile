SHELL:=/bin/bash
CPUS:=$(shell getconf _NPROCESSORS_ONLN)
SEQ:=$(shell seq $(CPUS))
DATA:=data.txt
.PHONY: $(SEQ)

$(DATA):
	dd if=/dev/urandom of=$(DATA) bs=1024 count=1024000
# 10240 = 10MB
# 102400 = 100MB
# 1024000 = 1000MB

# ~~~~~ Setup Conda ~~~~~ #
UNAME:=$(shell uname)
PATH:=$(CURDIR)/conda/bin:$(PATH)
unexport PYTHONPATH
unexport PYTHONHOME

# install versions of conda for Mac or Linux, Python 2 or 3
ifeq ($(UNAME), Darwin)
CONDASH:=Miniconda3-4.5.4-MacOSX-x86_64.sh
endif

ifeq ($(UNAME), Linux)
CONDASH:=Miniconda3-4.5.4-Linux-x86_64.sh
endif

CONDAURL:=https://repo.continuum.io/miniconda/$(CONDASH)
conda:
	@echo ">>> Setting up conda..."
	@wget "$(CONDAURL)" && \
	bash "$(CONDASH)" -b -p conda && \
	rm -f "$(CONDASH)"

conda-install: conda
	conda install -y -c anaconda pigz=2.4

setup: conda-install $(DATA)

test:
	pigz -p $(CPUS) -c $(DATA) > $(DATA).gz

run: $(SEQ)
$(SEQ):
	@echo ">>> Starting $(@)" && \
	TIMESTART="$$(date +%s)" && \
	pigz -p $(@) -c $(DATA) > $(DATA).$(@).gz && \
	FINISH="$$(( $$(date +%s) - $${TIMESTART}))" && \
	echo ">>> Finished $(@) in $${FINISH}s"

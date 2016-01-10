#!/usr/bin/make -f
# -*- makefile -*-

RSYNC := rsync
SRCS := $(glob 20*/*/*/*.rst)

all: build

prebuild:
	virtualenv ../.venv
	../.venv/bin/pip install -r requirements.txt

build: prebuild $(SRCES)
build: $(SRCES)
	. ../.venv/bin/activate; \
	tinker -b -q;\
	deactivate;

sync: build $(SRCES)
	rsync -av $(CURDIR)/blog/html/ ../geekdaddy.github.io/ ;\
	cd ../geekdaddy.github.io/ ;\
	git add . ;\
	git commit -m "Update `date +%Y%m%d`" ;\
	git push -u origin gh-pages

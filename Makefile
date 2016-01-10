#!/usr/bin/make -f
# -*- makefile -*-

SRCS := $(glob 20*/*/*/*.rst)
POST :=
PAGE :=

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
	rsync -av $(CURDIR)/blog/html/ ../geekdaddy.github.io/

publish: sync $(SRCES)
	cd ../geekdaddy.github.io/ ;\
	git add . ;\
	git commit -m "Update `date +%Y%m%d`" ;\
	git push -u origin master

post:
	../.venv/bin/tinker -p "$(POST)"

page:
	../.venv/bin/tinker --page "$(PAGE)"

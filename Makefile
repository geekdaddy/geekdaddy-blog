#!/usr/bin/make -f
# -*- makefile -*-

SRCS := $(glob 20*/*/*/*.rst)
POST :=
PAGE :=

all: build

prebuild:
	virtualenv -p /usr/bin/python3.6 ../.venv
	../.venv/bin/pip install -r requirements.txt

build: prebuild $(SRCES)
build: $(SRCES)
	. ../.venv/bin/activate; \
	tinker -b -q;\
	deactivate;

sync: build $(SRCES)
	rsync -av --exclude '.nojekyll' --exclude '.git' --exclude 'google89a373a2ce3930a3.html' --delete $(CURDIR)/blog/html/ ../geekdaddy.github.io/

publish: sync $(SRCES)
	cd ../geekdaddy.github.io/ ;\
	git add . ;\
	git commit -m "Update `date +%Y%m%d`" ;\
	git push -u origin master

post:
	../.venv/bin/tinker -p "$(POST)"

page:
	../.venv/bin/tinker --page "$(PAGE)"

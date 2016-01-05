handlers:=$(wildcard src/lifx-messages-*messages.ads)

all:generate compile test

#src/lifx-messages-dispatchers.ads:$(handlers) generate.py Makefile#  IGNORE

generate:#src/lifx-messages-dispatchers.ads
	@echo $(handlers)
	python generate.py

compile:generate
	gprbuild -p -P lifx.gpr

test:
	${MAKE} -C tests compile test

install:
	gprinstall -p -P lifx.gpr
	

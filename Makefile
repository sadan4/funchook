#!/usr/bin/env -S make -f
export DISASM ?= Zydis
Defines=$(shell ./defines.sh)
Sources=$(shell ./files.sh)
.DEFAULT_GOAL := all
export LDFLAGS=-static -fPIC
clean:
	rm -r dist || :
	rmdir dist || :
all: clean
	mkdir dist
	gcc -fPIC -Wall -I ./include $(Defines) $(Sources) -c
	mv *.o dist
	ar rcs dist/libfunchook.a dist/*.o
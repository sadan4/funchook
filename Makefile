#!/usr/bin/env -S make -f
export DISASM ?= Zydis
Defines=$(shell bash ./defines.sh)
Sources=$(shell bash ./files.sh)
.DEFAULT_GOAL := all
clean:
	rm -r dist || :
	rmdir dist || :
all: clean
	mkdir dist
	gcc -fPIC -Wall -I ./include $(Defines) $(Sources) -c
	mv *.o dist
	ar rcs dist/libfunchook.a dist/*.o $(ZYDIS_LOC)
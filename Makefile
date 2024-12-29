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
	gcc -ggdb3 -shared -fPIC -Wall -I ./include -I src -I src/Zydis $(Defines) $(Sources) -o dist/libfunchook.so
	# mv *.o dist
	# ar rcs dist/libfunchook.a dist/*.o $(ZYDIS_LOC)
pname ?= mylloc
out ?= /usr/local

prefix ?= ${out}
libdir ?= ${prefix}/lib
includedir ?= ${prefix}/include

CFLAGS ?= -g
CFLAGS += -fPIC -shared

.PHONY: all build clean install uninstall

all: build install

build:
	@${CC} ${CFLAGS} -o lib${pname}.so lib/fmalloc.c

clean:
	@rm lib${pname}.so

install: build
	@mkdir -p ${libdir} ${includedir}

	@install -Dm644 lib${pname}.so ${libdir}
	@install -Dm644 lib/include/fmalloc.h ${includedir}

uninstall:
	@rm ${libdir}/lib${pname}.so
	@rm ${includedir}/fmalloc.h

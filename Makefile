pname ?= mylloc
out ?= /usr/local

prefix ?= ${out}
libdir ?= ${prefix}/lib
includedir ?= ${prefix}/include

CFLAGS ?= -g
CFLAGS += -fPIC -shared

.PHONY: all build clean install test uninstall

all: build install

build:
	@${CC} ${CFLAGS} -o lib${pname}.so lib/fmalloc.c

clean:
	@rm lib${pname}.so
	@rm ${pname}-test

install: build
	@mkdir -p ${libdir} ${includedir}

	@install -Dm644 lib${pname}.so ${libdir}
	@install -Dm644 lib/include/fmalloc.h ${includedir}

test: install
	@${CC} -I${includedir} -L${libdir} -lmylloc -o ${pname}-test src/main.c

uninstall:
	@rm ${libdir}/lib${pname}.so
	@rm ${includedir}/fmalloc.h

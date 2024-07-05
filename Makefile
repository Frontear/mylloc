pname ?= mylloc
out ?= /usr/local

prefix ?= ${out}
libdir ?= ${prefix}/lib
includedir ?= ${prefix}/include

CFLAGS ?= -g

.PHONY: all build clean install test uninstall

all: build install

build:
	@${CC} -o lib${pname}.so ${CFLAGS} -fPIC -shared lib/fmalloc.c

clean:
	@rm -f lib${pname}.so
	@rm -f ${pname}-test

install: build
	@mkdir -p ${libdir} ${includedir}

	@install -Dm644 lib${pname}.so ${libdir}
	@install -Dm644 lib/include/fmalloc.h ${includedir}

test: install
	@${CC} -o ${pname}-test ${CFLAGS} -I${includedir} -L${libdir} -lmylloc src/main.c
	@gdb ./${pname}-test

uninstall:
	@rm ${libdir}/lib${pname}.so
	@rm ${includedir}/fmalloc.h

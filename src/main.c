#include <stdio.h>
#include <unistd.h>

#include "fmalloc.h";

int main(void) {
    int *p = fmalloc(sizeof(int));

    *p = 12345;

    ffree(p);

    return 0;
}

void* fmalloc(size_t size) {
    sbrk(0 + sizeof(size_t) + size);
    size_t *addr = sbrk(0);

    *addr = size;
    addr += sizeof(size_t);

    return addr;
}

void ffree(void *addr) {
    addr -= sizeof(size_t);
    size_t size = *((size_t*) addr);

    sbrk(0 - sizeof(size_t) - size);
}

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#include "fmalloc.h";

int main(void) {
    int *p = fmalloc(sizeof(int));

    *p = 12345;
    printf("%d\n", *p);

    ffree(p);

    return 0;
}

void* fmalloc(size_t size) {
    int fd = open("/dev/zero", O_RDONLY);
    size_t *addr = mmap(NULL, sizeof(size_t) + size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
    close(fd);

    *addr = size;
    addr += sizeof(size_t);

    return addr;
}

void ffree(void *addr) {
    addr -= sizeof(size_t);
    size_t size = *((size_t*) addr);

    munmap(addr, size);
}

#include "include/fmalloc.h"

#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>

typedef struct {
    size_t size;
} blk_hdr;

void *malloc(size_t size) {
    blk_hdr hdr = { .size = size };
    void *buff = mmap(NULL, sizeof(blk_hdr) + size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    *((blk_hdr*) buff) = hdr;

    return (buff += sizeof(blk_hdr));
}

void free(void *buff) {
    buff -= sizeof(blk_hdr);
    blk_hdr hdr = *((blk_hdr*) buff);

    munmap(buff, hdr.size);
}

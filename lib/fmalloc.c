#include "include/fmalloc.h"

#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>

typedef struct {
    size_t block_size;
} meta;

void *malloc(size_t size) {
    size_t block_size = sizeof(meta) + size; // TODO: alignment?
    meta *block = mmap(NULL, block_size, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

    block->block_size = block_size;
    block += sizeof(meta);

    return block;
}

void free(void *buff) {
    buff -= sizeof(meta);
    meta *block = buff;

    munmap(buff, block->block_size);
}

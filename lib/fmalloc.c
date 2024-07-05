#include "include/fmalloc.h"

#include <fcntl.h>
#include <stddef.h>
#include <sys/mman.h>

typedef struct {
    size_t size;
} blk_hdr;

// keep it alive for our lifetime and allow kernel to cleanup
int dev_zero_fd = -1;

void* fmalloc(size_t size) {
    if (dev_zero_fd == -1) {
        dev_zero_fd = open("/dev/zero", O_RDONLY);
    }

    blk_hdr hdr = { .size = size };
    void *buff = mmap(NULL, sizeof(blk_hdr) + size, PROT_READ | PROT_WRITE, MAP_PRIVATE, dev_zero_fd, 0);
    *((blk_hdr*) buff) = hdr;

    return (buff += sizeof(blk_hdr));
}

void ffree(void *buff) {
    buff -= sizeof(blk_hdr);
    blk_hdr hdr = *((blk_hdr*) buff);

    munmap(buff, hdr.size);
}

#ifndef FRONTEAR_MALLOC
#define FRONTEAR_MALLOC

#include <stdint.h>

void* fmalloc(size_t size);
void ffree(void *addr);

#endif

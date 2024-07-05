#ifndef FRONTEAR_MALLOC
#define FRONTEAR_MALLOC

#include <stdint.h>

void* fmalloc(size_t);
void ffree(void*);

#endif

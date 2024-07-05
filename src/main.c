#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#include <fmalloc.h>

int main(void) {
    int *p = fmalloc(sizeof(int));

    *p = 12345;
    printf("%d\n", *p);

    ffree(p);

    return 0;
}

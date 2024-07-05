#include <fmalloc.h>
#include <stdio.h>

int main(void) {
    int *p = malloc(sizeof(int));

    *p = 12345;
    printf("%d\n", *p);

    free(p);

    return 0;
}

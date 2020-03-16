# Minimalist GPU Clock Benchmarking for kernels
## How to use
```
#include <clocker>

BENCHINIT();

__global__ void kernel(...) {
    BENCHBEGIN(); /// start 
    ...
    BENCHEND(); /// end
}

int main() {
    ...
    Memcpy
    kernel<<<1,size>>>(...);
    PRINTDATA();
}
```

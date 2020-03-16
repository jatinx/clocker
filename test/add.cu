#include <clocker.h>
#include <iostream>

BENCHINIT();

__global__ void add(int *i1, int *i2, int *o) { // o[] = i1[] + i2[]
    BENCHBEGIN();

    int tid = threadIdx.x;
    o[tid] = i1[tid] + i2[tid];

    o[tid] *= 2;

    o[tid] -= i1[tid];
    o[tid] -= i2[tid];

    BENCHEND();
}

int main() {
    const int size = 512;
    int a[size], c[size];
    int *d_i1, *d_i2, *d_o;

    cudaMalloc(&d_i1, sizeof(int) * size);
    cudaMalloc(&d_i2, sizeof(int) * size);
    cudaMalloc(&d_o, sizeof(int) * size);

    for (int i = 0; i < size; i++) {
      a[i] = i + 1;
      c[i] = 0;
    }

    cudaMemcpy(d_i1, a, sizeof(int) * size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_i2, a, sizeof(int) * size, cudaMemcpyHostToDevice);

    add<<<1, size>>>(d_i1, d_i2, d_o);

    cudaMemcpy(c, d_o, sizeof(int) * size, cudaMemcpyDeviceToHost);

    for (int i = 0; i < size; i++) {
      if (c[i] != (2 * (i + 1))) {
        std::cout << "Failed Verification for::" << i << " - " << c[i] << " - "
                  << (2 * (i + 1)) << " - " << a[i] << std::endl;
      }
    }

    cudaFree(d_i1);
    cudaFree(d_i2);
    cudaFree(d_o);

    PRINTDATA();
}

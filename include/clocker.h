#pragma once

#include <iostream>

#define BENCHINIT() __device__ long long int thrd0_timer;

#define BENCHBEGIN() long long int __start_t0_timer = clock64();

#define BENCHEND()                                                             \
  {                                                                            \
    long long int __end_t0_timer = clock64();                                  \
    if (threadIdx.x == 0) {                                                    \
      thrd0_timer = __end_t0_timer - __start_t0_timer;                         \
    }                                                                          \
  }

#define PRINTDATA()                                                            \
  {                                                                            \
    long long int d = 0;                                                       \
    cudaMemcpyFromSymbol(&d, thrd0_timer, sizeof(long long int), 0,            \
                         cudaMemcpyDeviceToHost);                              \
    std::cout << d << std::endl;                                               \
  }

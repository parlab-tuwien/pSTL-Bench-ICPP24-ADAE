#!/bin/bash

PSTL_FOLDER=~/pSTL-Bench

# Compile GCC-SEQ
OUTPUT_FOLDER=${PSTL_FOLDER}/build-gcc-seq
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-12 -DCMAKE_C_COMPILER=gcc-12
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j

# Compile GCC-GNU
OUTPUT_FOLDER=${PSTL_FOLDER}/build-gcc-gnu
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-12 -DCMAKE_C_COMPILER=gcc-12 -DPSTL_BENCH_BACKEND=GNU -DPSTL_BENCH_USE_PAR_ALLOC=ON
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j

# Compile GCC-TBB
OUTPUT_FOLDER=${PSTL_FOLDER}/build-gcc-tbb
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-12 -DCMAKE_C_COMPILER=gcc-12 -DPSTL_BENCH_BACKEND=TBB -DPSTL_BENCH_USE_PAR_ALLOC=ON
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j

# Compile GCC-HPX
OUTPUT_FOLDER=${PSTL_FOLDER}/build-gcc-hpx
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++-12 -DCMAKE_C_COMPILER=gcc-12 -DPSTL_BENCH_BACKEND=HPX
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j

# Compile ICC-TBB
OUTPUT_FOLDER=${PSTL_FOLDER}/build-icc-tbb
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=icpx -DCMAKE_C_COMPILER=icx -DPSTL_BENCH_BACKEND=TBB -DPSTL_BENCH_USE_PAR_ALLOC=ON
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j

# Compile NVC-OMP
OUTPUT_FOLDER=${PSTL_FOLDER}/build-nvc-omp
cmake -S ${PSTL_FOLDER} -B ${OUTPUT_FOLDER} -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=nvc++ -DCMAKE_C_COMPILER=nvc -DPSTL_BENCH_BACKEND=NVHPC_OMP -DPSTL_BENCH_USE_PAR_ALLOC=ON
cmake --build ${OUTPUT_FOLDER} --target pSTL-Bench -j


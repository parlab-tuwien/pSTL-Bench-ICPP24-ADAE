#!/bin/bash

PSTL_FOLDER=~/pSTL-Bench
RESULTS_FOLDER=~/results/fig5a

if [ -z "$PSTL_MIN_TIME" ]; then
	PSTL_MIN_TIME=1s
fi
PSTL_FMT=json

# Run GCC-SEQ
OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-SEQ/
mkdir -p ${OUTPUT_FOLDER}
${PSTL_FOLDER}/build-gcc-seq/pSTL-Bench --benchmark_filter="SEQ/std::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

# Run GCC-GNU -> This benchmark is not available for inclusive_scan
# OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-GNU/
# mkdir -p ${OUTPUT_FOLDER}
# ${PSTL_FOLDER}/build-gcc-gnu/pSTL-Bench --benchmark_filter="OMP/gnu::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

# Run GCC-TBB
OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-TBB/
mkdir -p ${OUTPUT_FOLDER}
${PSTL_FOLDER}/build-gcc-tbb/pSTL-Bench --benchmark_filter="TBB/std::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

# Run GCC-HPX
OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-HPX/
mkdir -p ${OUTPUT_FOLDER}
${PSTL_FOLDER}/build-gcc-hpx/pSTL-Bench --benchmark_filter="HPX/hpx::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

# Run ICC-TBB
OUTPUT_FOLDER=${RESULTS_FOLDER}/ICC-TBB/
mkdir -p ${OUTPUT_FOLDER}
${PSTL_FOLDER}/build-icc-tbb/pSTL-Bench --benchmark_filter="TBB/std::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

# Run NVC-OMP
OUTPUT_FOLDER=${RESULTS_FOLDER}/NVC-OMP/
mkdir -p ${OUTPUT_FOLDER}
${PSTL_FOLDER}/build-nvc-omp/pSTL-Bench --benchmark_filter="OMP/std::inclusive_scan" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/inclusive_scan.json

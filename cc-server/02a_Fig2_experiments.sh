#!/bin/bash

PSTL_FOLDER=~/pSTL-Bench
RESULTS_FOLDER=~/results/fig2

if [ -z "$PSTL_MIN_TIME" ]; then
	PSTL_MIN_TIME=1s
fi
PSTL_FMT=json

FOR_EACH_ITS_VALUES="1 1000"

for its in $FOR_EACH_ITS_VALUES; do
	echo "Running experiments with computational intensity k_{it}: $its"

	export PSTL_BENCH_FOR_EACH_KERNEL_ITS=$its

	# Run GCC-SEQ
	OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-SEQ/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-gcc-seq/pSTL-Bench --benchmark_filter="SEQ/std::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

	# Run GCC-GNU
	OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-GNU/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-gcc-gnu/pSTL-Bench --benchmark_filter="OMP/gnu::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

	# Run GCC-TBB
	OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-TBB/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-gcc-tbb/pSTL-Bench --benchmark_filter="TBB/std::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

	# Run GCC-HPX
	OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-HPX/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-gcc-hpx/pSTL-Bench --benchmark_filter="HPX/hpx::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

	# Run ICC-TBB
	OUTPUT_FOLDER=${RESULTS_FOLDER}/ICC-TBB/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-icc-tbb/pSTL-Bench --benchmark_filter="TBB/std::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

	# Run NVC-OMP
	OUTPUT_FOLDER=${RESULTS_FOLDER}/NVC-OMP/
	mkdir -p ${OUTPUT_FOLDER}
	${PSTL_FOLDER}/build-nvc-omp/pSTL-Bench --benchmark_filter="OMP/std::for_each" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json
done

#!/bin/bash

PSTL_FOLDER=~/pSTL-Bench
RESULTS_FOLDER=~/results/fig3

if [ -z "$PSTL_MIN_TIME" ]; then
	PSTL_MIN_TIME=1s
fi
PSTL_FMT=json

FOR_EACH_ITS_VALUES="1 1000"

INPUT_SIZE=$((2 ** 30))

MAX_THREADS=$(nproc)

THREADS_SEQ=`bash_scripts/gen_seq.sh 1 $MAX_THREADS 4`

for NUM_THREADS in $THREADS_SEQ; do
	echo "Running experiments with $NUM_THREADS threads"

	export OMP_NUM_THREADS=$NUM_THREADS

	for its in $FOR_EACH_ITS_VALUES; do
		echo "Running experiments with computational intensity k_{it}: $its"

		export PSTL_BENCH_FOR_EACH_KERNEL_ITS=$its

		# Run GCC-SEQ
		if [ $NUM_THREADS -eq 1 ]; then
			OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-SEQ/${NUM_THREADS}_threads
			mkdir -p ${OUTPUT_FOLDER}
			${PSTL_FOLDER}/build-gcc-seq/pSTL-Bench --benchmark_filter="SEQ/std::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json
		fi

		# Run GCC-GNU
		OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-GNU/${NUM_THREADS}_threads
		mkdir -p ${OUTPUT_FOLDER}
		${PSTL_FOLDER}/build-gcc-gnu/pSTL-Bench --benchmark_filter="OMP/gnu::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

		# Run GCC-TBB
		OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-TBB/${NUM_THREADS}_threads
		mkdir -p ${OUTPUT_FOLDER}
		${PSTL_FOLDER}/build-gcc-tbb/pSTL-Bench --benchmark_filter="TBB/std::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

		# Run GCC-HPX
		OUTPUT_FOLDER=${RESULTS_FOLDER}/GCC-HPX/${NUM_THREADS}_threads
		mkdir -p ${OUTPUT_FOLDER}
		${PSTL_FOLDER}/build-gcc-hpx/pSTL-Bench --benchmark_filter="HPX/hpx::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json --hpx:threads=${NUM_THREADS}

		# Run ICC-TBB
		OUTPUT_FOLDER=${RESULTS_FOLDER}/ICC-TBB/${NUM_THREADS}_threads
		mkdir -p ${OUTPUT_FOLDER}
		${PSTL_FOLDER}/build-icc-tbb/pSTL-Bench --benchmark_filter="TBB/std::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json

		# Run NVC-OMP
		OUTPUT_FOLDER=${RESULTS_FOLDER}/NVC-OMP/${NUM_THREADS}_threads
		mkdir -p ${OUTPUT_FOLDER}
		${PSTL_FOLDER}/build-nvc-omp/pSTL-Bench --benchmark_filter="OMP/std::for_each/.*/${INPUT_SIZE}" --benchmark_min_time=${PSTL_MIN_TIME} --benchmark_out_format=${PSTL_FMT} --benchmark_out=${OUTPUT_FOLDER}/for_each_its_${its}.json
	done
done

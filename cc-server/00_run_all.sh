#!/bin/bash

scripts=`ls *.sh | grep -E 0[1-9]`

echo "Start at: `date`"
start_time=`date +%s`

for script in ${scripts}; do
	it_start_time=`date +%s`

	echo "Running ${script}..."
	./${script}

	it_end_time=`date +%s`
	elapsed_time=$((it_end_time - it_start_time))

	secs=$((elapsed_time % 60))
	mins=$(( (elapsed_time / 60) % 60 ))
	hours=$((elapsed_time / 3600))
	echo "Done (${script}) in ${hours}h ${mins}m ${secs}s"
done

echo "End at: `date`"
end_time=`date +%s`

elapsed_time=$((end_time - start_time))

secs=$((elapsed_time % 60))
mins=$(( (elapsed_time / 60) % 60 ))
hours=$((elapsed_time / 3600))

echo "Total elapsed: ${hours}h ${mins}m ${secs}s"
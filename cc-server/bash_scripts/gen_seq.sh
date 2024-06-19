#!/bin/bash

min=1
max=$(nproc)
step=2

if [ $# -lt 3 ]; then
	echo "Usage: $0 <min> <max> <step>"
	exit 1
fi

min=$1
max=$2
step=$3

sequence="1"

last=$sequence

while [ $last -lt $max ]; do
	last=$((last * step))
	if [ $last -gt $max ]; then
		sequence="$sequence $max"
	else
		sequence="$sequence $last"
	fi
done

echo $sequence

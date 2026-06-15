#!/bin/bash

mkdir -p tmp

# remove stale files from previous runs

rm -f hogprop_output.h5
rm -f tmp/output.h5

conda activate sib_course

./fastoma_convert \
    ../step1_annotation/go-basic.obo \
    ./hogprop_results/ \
    ./tmp/output.h5

cp tmp/output.h5 hogprop_output.h5

#!/bin/sh

# Number of CPU available
N_CPU=12
# LINEAGE PARAMETER!
LINEAGE="-l tetrapoda_odb12.2"
# INPUT FILE, must be in the current directory!
INPUT_FASTA=$1
cp -r /vol/Topic4CommonData/Module1/tetrapoda_odb12.2 ./
# ADD YOUR CODE HERE

# HINT
#docker run -u $(id -u) -v $(pwd):/busco_wd  # ETC...


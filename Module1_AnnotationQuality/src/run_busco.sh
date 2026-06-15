#!/bin/sh

N_CPU=12
LINEAGE="-l tetrapoda_odb12.2"
INPUT_FASTA=$1

docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.1.0_cv1 busco -i $INPUT_FASTA -m proteins $LINEAGE -c $N_CPU
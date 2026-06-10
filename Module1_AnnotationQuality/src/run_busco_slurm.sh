#!/bin/sh
#SBATCH --job-name=busco_runner
#SBATCH -c 4
#SBATCH --mem=20G
#SBATCH -o slurms/array/omark_slurm-%j.out
#SBATCH -t 3-0
#SBATCH -p cpu
#SBATCH --array 1-10  # specify here right number of proteomes

LINEAGE="-l tetrapoda_odb12.2"
docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.1.0_cv1 busco -i ./Aptenodytes_forsteri.fa -m proteins $LINEAGE -c $SLURM_CPUS_PER_TASK
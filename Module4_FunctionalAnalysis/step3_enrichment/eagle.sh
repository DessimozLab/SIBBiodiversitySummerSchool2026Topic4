#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=6:00:00
#SBATCH --job-name=eagle
#SBATCH --output=logs/eagle_%A_%a.out
#SBATCH --array=1-50

MYID=${SLURM_ARRAY_TASK_ID}
NJOBS=${SLURM_ARRAY_TASK_MAX}

mamba activate sib_course

RESULTS_PATH=./eagle_results
mkdir -p ${RESULTS_PATH}

eagle --obo /work/FAC/FBM/DBC/cdessim2/default/awarwick/sib_course/go-basic.obo \
      --oxml /work/FAC/FBM/DBC/cdessim2/default/summer_school2026/mini_dataset/fastoma_output/FastOMA_HOGs.orthoxml \
      --nwk species_tree.nwk \
      --hogprop_results /work/FAC/FBM/DBC/cdessim2/default/awarwick/sib_course/step2_propagation/hogprop_output.h5 \
      --results ${RESULTS_PATH} \
      --skip_terminal \
      --include_genelist \
      --write_extant_genelist \
      --myid ${MYID} --njobs ${NJOBS}

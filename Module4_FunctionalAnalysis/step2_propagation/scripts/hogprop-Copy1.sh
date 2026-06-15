#!/bin/bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=24G
#SBATCH --time=6:00:00
#SBATCH --job-name=hogprop
#SBATCH --output=logs/hogprop_%A_%a.out
#SBATCH --array=1-50

MYID=1
NJOBS=50

mkdir -p hogprop_results

conda activate sib_course

hogprop \
    --obo ../step1_annotation/go-basic.obo \
    --gaf ../step1_annotation/extant_predictions.gaf.gz \
    --go_filter all \
    --combination_func max \
    --oxml /work/FAC/FBM/DBC/cdessim2/default/summer_school2026/mini_dataset/fastoma_output/FastOMA_HOGs.orthoxml \
    --no_convert \
    --results hogprop_results/output.h5 \
    --myid ${MYID} \
    --njobs ${NJOBS}
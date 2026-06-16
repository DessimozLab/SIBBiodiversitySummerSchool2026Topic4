#!/bin/sh

# Number of CPU available
N_CPU=12
# LINEAGE PARAMETER!
LINEAGE="-l ./tetrapoda_odb12.2"

# path to folders
TMPDIR=/scratch/busco_run/ # set here the tmp folder in the cluster
SIBBSS_PATH=/home/ubuntu/SIBBiodiversitySummerSchool2026Topic4/
MODULE1_PATH=${SIBBSS_PATH}/Module1_AnnotationQuality
COMMONDATA_PATH=/vol/Topic4CommonData/shared/
INPUT_FOLD=${COMMONDATA_PATH}/proteomes/

# input genomes list is the list of proteomes in input folder
PROTEOME_LIST=$(ls $INPUT_FOLD)
# path to output folder
SAVED_OUT_FOLD=${MODULE1_PATH}/out/busco/busco_output/
mkdir -p $SAVED_OUT_FOLD

# Get the file for this  task
for current_fasta in $PROTEOME_LIST
do
  #work dir
  WORK_DIR=${TMPDIR}/${current_fasta%.fa}
  mkdir -p $WORK_DIR
  cd $WORK_DIR
  echo "now we are in $PWD"
  # copy fasta here
  cp ${INPUT_FOLD}/$current_fasta ./
  # copy lineage here
  cp -r /vol/Topic4CommonData/Module1/tetrapoda_odb12.2 ./

  echo docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.1.0_cv1 busco -i $current_fasta -m proteins $LINEAGE -c $N_CPU
  docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v6.1.0_cv1 busco -i $current_fasta -m proteins $LINEAGE -c $N_CPU

  # copy results and remove temporary output folder
  echo cp -r BUSCO_$current_fasta $SAVED_OUT_FOLD && rm -r tetrapoda_odb12.2 # && rm -r BUSCO_$current_fasta
  cp -r BUSCO_$current_fasta $SAVED_OUT_FOLD && rm -r tetrapoda_odb12.2 # && rm -r BUSCO_$current_fasta

done

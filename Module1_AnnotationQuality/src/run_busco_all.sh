#!/bin/sh

# Number of CPU available
N_CPU=12
# LINEAGE PARAMETER!
LINEAGE="-l tetrapoda_odb12.2"

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

# Get the file for this  task
for current_fasta in $PROTEOME_LIST
do
  # create a temporary work directory ready to run busco (including lineage information)
  WORK_DIR=${TMPDIR}/${current_fasta%.fa}
  mkdir -p $WORK_DIR
  cd $WORK_DIR
  echo "now we are in $PWD"
  # copy fasta here
  cp ${INPUT_FOLD}/$current_fasta ./
  # copy lineage here
  cp -r /vol/Topic4CommonData/Module1/tetrapoda_odb12.2 ./
  # ADD YOUR CODE HERE

  # copy results and remove temporary output folder
  cp -r $OUT_DIR/ $SAVED_OUT_FOLD && rm -r $OUT_DIR

done

# HINT
#docker run -u $(id -u) -v $(pwd):/busco_wd  # ETC...


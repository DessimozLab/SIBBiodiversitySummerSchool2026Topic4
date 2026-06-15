#!/bin/sh

# Number of CPU available
N_CPU=12

# TAXID PARAMETER!
TID_PARAM=" -t 32524" # the last common ancestor (Amniota)

# path to folders
TMPDIR=~/scratch/omark_run/ # set here the tmp folder in the cluster
SIBBSS_PATH=$(realpath $PWD/../../)  # assuming we are in Module1/src/
MODULE1_PATH=${SIBBSS_PATH}/Module1_AnnotationQuality
COMMONDATA_PATH=/vol/Topic4CommonData/Module1/
INPUT_FOLD=${COMMONDATA_PATH}/proteomes/

# activate right conda environment
eval "$(conda shell.bash hook)"
conda activate module1env  # put here the name of the env with OMArk

# input genomes list is the list of proteomes in input folder
PROTEOME_LIST=$(ls $INPUT_FOLD)
# path to omamer
OMAMER_DB_PATH=${COMMONDATA_PATH}/omamerdb.h5
# path to intermediate and final output
OMAMER_FOLD=${MODULE1_PATH}/out/omark/hogmap/
SAVED_OUT_FOLD=${MODULE1_PATH}/out/omark/omark_output/

# Get the file for this array task
for current_fasta in $PROTEOME_LIST
do

  GEN_ID=${current_fasta%.fa}

  #work dir
  WORK_DIR=${TMPDIR}/work/$GEN_ID
  mkdir -p $WORK_DIR
  cd $WORK_DIR

  # out dir
  OUT_DIR=${TMPDIR}/out/$GEN_ID
  mkdir -p $OUT_DIR

  # if output is not there already
  if [ ! -f $OUT_DIR/omamer_output.txt ] && [ ! -f $SAVED_OUT_FOLD/$GEN_ID/omamer_output.txt ]
  then

     # search with omamer
     echo   omamer search --db $OMAMER_DB_PATH --query ${INPUT_FOLD}/$current_fasta --nthreads $N_CPU --out omamer_output.txt
     omamer search --db $OMAMER_DB_PATH --query ${INPUT_FOLD}/$current_fasta --nthreads $N_CPU --out omamer_output.txt

     # run omark
     echo    omark -f omamer_output.txt -d $OMAMER_DB_PATH -o $OUT_DIR -of ${INPUT_FOLD}/$current_fasta  -v $TID_PARAM
     omark -f omamer_output.txt -d $OMAMER_DB_PATH -o $OUT_DIR -of ${INPUT_FOLD}/$current_fasta  -v $TID_PARAM

  fi

  # copy results and remove temporary output folder
  cp -r $OUT_DIR/ $SAVED_OUT_FOLD && rm -r $OUT_DIR

done

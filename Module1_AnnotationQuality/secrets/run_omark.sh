#!/bin/sh

# Number of CPU available
N_CPU=12
# TAXID PARAMETER!
TID_PARAM=" -t 32524" # the last common ancestor (Amniota)
# INPUT FILE
INPUT_FASTA=$1

# path to omamer
COMMONDATA_PATH=/vol/Topic4CommonData/shared/
OMAMER_DB_PATH=${COMMONDATA_PATH}/omamerdb.h5
# path to omamer results
PROT_NAME=$(basename ${INPUT_FASTA%.fa})
mkdir $PROT_NAME
OMAMER_OUT=${PROT_NAME}/${PROT_NAME}_omamer_output.txt

# if output is not there already
if [ ! -f $OMAMER_OUT ]
then

   # search with omamer
   echo   omamer search --db $OMAMER_DB_PATH --query $INPUT_FASTA --nthreads $N_CPU --out $OMAMER_OUT
   omamer search --db $OMAMER_DB_PATH --query $INPUT_FASTA --nthreads $N_CPU --out $OMAMER_OUT

   # run omark
   echo    omark -f $OMAMER_OUT -d $OMAMER_DB_PATH -o $PROT_NAME/ -of $INPUT_FASTA  -v $TID_PARAM
   omark -f $OMAMER_OUT -d $OMAMER_DB_PATH -o $PROT_NAME/ -of $INPUT_FASTA  -v $TID_PARAM

fi

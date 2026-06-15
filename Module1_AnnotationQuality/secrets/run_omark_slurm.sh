#!/bin/sh
#SBATCH --job-name=omark_runner
#SBATCH -c 4
#SBATCH --mem=20G
#SBATCH -o slurms/array/omark_slurm-%j.out
#SBATCH -t 3-0
#SBATCH -p cpu
#SBATCH --array 1-10  # specify here right number of proteomes

# TAXID PARAMETER!
TID_PARAM=" -t 32524" # the last common ancestor (Amniota)

# path to folders
TMPDIR=/scratch/omark_run/ # set here the tmp folder in the cluster
SIBBSS_PATH=$(realpath $PWD/../../)  # assuming we are in Module1/src/
MODULE1_PATH=${SIBBSS_PATH}/Module1_AnnotationQuality
COMMONDATA_PATH=/vol/CommonDataModule1
INPUT_FOLD=${COMMONDATA_PATH}/minidataset/proteome/

# activate right conda environment
eval "$(conda shell.bash hook)"
conda activate denbi  # put here the name of the env with OMArk

# input genomes list is a csv with genome_path,genome_ID,taxID
PROTEOME_LIST=${COMMONDATA_PATH}/minidataset/proteome_list.txt
# path to omamer
OMAMER_DB_PATH=${COMMONDATA_PATH}/omamerdb.h5
# path to intermediate and final output
OMAMER_FOLD=${MODULE1_PATH}/out/omark/hogmap/
SAVED_OUT_FOLD=${MODULE1_PATH}/out/omark/omark_output/

# get one row for slurm array job
readarray -t files <${PROTEOME_LIST}

# Get the number of files
num_files=${#files[@]}

# Get the file for this array task
current_fasta=${files[$SLURM_ARRAY_TASK_ID-1]}
GEN_ID=${current_fasta%.fa}

#work dir
WORK_DIR=${TMPDIR}/work/$GEN_ID
mkdir -p $WORK_DIR
cd $WORK_DIR
cp $OMAMER_DB_PATH .

# out dir
OUT_DIR=${TMPDIR}/out/$GEN_ID
mkdir -p $OUT_DIR

# if output is not there already
if [ ! -f $OUT_DIR/omamerized.sum ] && [ ! -f $SAVED_OUT_FOLD/$GEN_ID/omamerized.sum ]
then

   # search with omamer
   echo   omamer search --db $(basename $OMAMER_DB_PATH) --query ${INPUT_FOLD}/$current_fasta --nthreads $SLURM_CPUS_PER_TASK --out omamerized.txt
   omamer search --db $(basename $OMAMER_DB_PATH) --query ${INPUT_FOLD}/$current_fasta --nthreads $SLURM_CPUS_PER_TASK --out omamerized.txt

   # run omark
   echo    omark -f omamerized.txt -d $(basename $OMAMER_DB_PATH) -o $OUT_DIR -of ${INPUT_FOLD}/$current_fasta  -v $TID_PARAM
   omark -f omamerized.txt -d $(basename $OMAMER_DB_PATH) -o $OUT_DIR -of ${INPUT_FOLD}/$current_fasta  -v $TID_PARAM

fi

cp -r $OUT_DIR/ $SAVED_OUT_FOLD

if [ ! -f $SAVED_OUT_FOLD/$GEN_ID/omamerized.sum ]; then
    cp $OUT_DIR/omamerized.sum $SAVED_OUT_FOLD/$GEN_ID/omamerized.sum
fi

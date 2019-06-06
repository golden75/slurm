#!/bin/bash
#SBATCH --job-name=humann2_Array
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --partition=general
#SBATCH --mail-type=END
#SBATCH --qos=general
#SBATCH --mem=40G
#SBATCH --array=[1-35]%5
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err

hostname

module load humann2/0.11.1
nucleotide_DB="/isg/shared/databases/humann2/chocophlan"
protein_DB="/isg/shared/databases/humann2/uniref90"


INPUT_FILES=(10_nohuman 11_nohuman 14_concat 21_concat 25_concat 27_concat 28_concat 29_concat 30_concat 32_concat 34_noHuman 36_noHuman 38_noHuman 39_concat 40_concat 41_concat 46_noHuman 4_concat 51_concat 55_noHuman 58_concat 62_noHuman 67_concat 6_concat 70_concat 71_concat 72_concat 77_concat 78_concat 79_concat 7_concat 81_concat 83_concat 86_concat 9_concat)
INPUT_FILE_NAME="${INPUT_FILES[$SLURM_ARRAY_TASK_ID - 1]}"

echo "host name : " `hostname`
echo "input file name : " $INPUT_FILE_NAME 
echo "SLURM_ARRAY_TASK_ID : " $SLURM_ARRAY_TASK_ID

humann2 --input ${INPUT_FILE_NAME}.fastq \
        --output ${INPUT_FILE_NAME}_OUT \
        --nucleotide-database ${nucleotide_DB} \
        --protein-database ${protein_DB} \
        --metaphlan-options "--bowtie2db /isg/shared/apps/MetaPhlAn/2.0/db_v20 --mpa_pkl /isg/shared/apps/MetaPhlAn/2.0/db_v20/mpa_v20_m200.pkl" \
        --threads 8

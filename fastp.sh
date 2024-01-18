#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=2
#SBATCH --mem=20G
#SBATCH --array=0-31

FILES=(*_R1_001.fastq.gz)

conda init bash
source ~/.bashrc
conda activate /mnt/shared/scratch/rmacleod/apps/conda/envs/metagenomics

fastp -l 20 -g --poly_g_min_len 8 -A -i ${FILES[$SLURM_ARRAY_TASK_ID]} -I ${FILES[$SLURM_ARRAY_TASK_ID]%_R1_001.fastq.gz}_R2_001.fastq.gz -o ${FILES[$SLURM_ARRAY_TASK_ID]%.fastq.gz}.fp_gmin8.fastq.gz -O ${FILES[$SLURM_ARRAY_TASK_ID]%_R1_001.fastq.gz}_R2_001.fp_gmin8.fastq.gz

#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=6
#SBATCH --mem=10G
#SBATCH --array=0-67

FILES=(*_R1_001.fastq.gz)

conda init bash
source ~/.bashrc
conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

AdapterRemoval --collapse-conservatively --threads 8 --file1 ${FILES[$SLURM_ARRAY_TASK_ID]} --file2 ${FILES[$SLURM_ARRAY_TASK_ID]%_R1_001.fastq.gz}_R1_001.fastq.gz --minlength 30 --basename ${FILES[$SLURM_ARRAY_TASK_ID]%_R2_001.fastq.gz} --gzip --adapter1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --adapter2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

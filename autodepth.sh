#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=3
#SBATCH --mem=5G
#SBATCH --array=0-11

conda init bash
source ~/.bashrc
FILES=(*.bam)

conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

samtools depth -a -Q 30 -q 20 -b /home/rmacleod/scratch/private/shamanka2/hg38/WholeGenomeFasta/genome.bed ${FILES[$SLURM_ARRAY_TASK_ID]} | datamash mean 3 >
${FILES[$SLURM_ARRAY_TASK_ID]}.autodepth.txt

#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --array=0-7

BAM=(*.merged.bam)
out=${BAM[$SLURM_ARRAY_TASK_ID]//merged.bam/merged.md.bam}
metrics=${BAM[$SLURM_ARRAY_TASK_ID]//merged.bam/.md.metrics}

conda init bash
source ~/.bashrc
conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

picard MarkDuplicates OPTICAL_DUPLICATE_PIXEL_DISTANCE=12000 I=${BAM[$SLURM_ARRAY_TASK_ID]} o=$out REMOVE_DUPLICATES=false METRICS_FILE=$metrics TAGGING_POLICY=All VALIDATION_STRINGENCY=LENIENT

#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=3
#SBATCH --mem=5G
#SBATCH --array=0-11

FILES=(*.bam)

conda init bash
source ~/.bashrc
conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

samtools depth -a -Q 30 -q 20 -b /home/rmacleod/scratch/private/shamanka2/hg38/WholeGenomeFasta/genome.bed ${FILES[$SLURM_ARRAY_TASK_ID]} | datamash mean 3 > ${FILES[$SLURM_ARRAY_TASK_ID]}.autodepth.txt

#option for 1240K positions
### samtools depth -Q 30 -q 20 -b /mnt/shared/scratch/rmacleod/private/shamanka2/EBA_hg19/bams/1240K_positions.bed ${FILES[$SLURM_ARRAY_TASK_ID]} | datamash mean 3 > ${FILES[$SLURM_ARRAY_TASK_ID]}.autodepth.txt
#count SNPs with >= 1 read coverage
### for i in *.bam ; do echo $i ; samtools depth -Q 30 -q 20 -b chr1-22_1240K_positions.bed $i | awk '$3!="0"'| wc -l ; done

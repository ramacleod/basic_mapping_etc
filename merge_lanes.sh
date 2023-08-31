#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=9
#SBATCH --mem=12G
#SBATCH --array=0-16

L1C=(*_L001.collapsed.bam)
L2C=${L1C[$SLURM_ARRAY_TASK_ID]//L001/L002}
L3C=${L1C[$SLURM_ARRAY_TASK_ID]//L001/L003}
L2C=${L1C[$SLURM_ARRAY_TASK_ID]//L003/L003}
L1P=${L1C[$SLURM_ARRAY_TASK_ID]//L001.collapsed.bam/L001.paired.bam}
L2P=${L1C[$SLURM_ARRAY_TASK_ID]//L001.collapsed.bam/L002.paired.bam}
L3P=${L1C[$SLURM_ARRAY_TASK_ID]//L001.collapsed.bam/L003.paired.bam}
L4P=${L1C[$SLURM_ARRAY_TASK_ID]//L001.collapsed.bam/L004.paired.bam}
SM=${L1C[$SLURM_ARRAY_TASK_ID]:0:66}

conda init bash
source ~/.bashrc
conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

samtools merge -o ${SM}.merged.bam -@8 $L1C $L2C $L3C $L4C $L1P $L2P $L3P $L4P

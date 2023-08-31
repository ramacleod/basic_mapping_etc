#!/bin/bash

#SBATCH --partition=medium
#SBATCH --cpus-per-task=9
#SBATCH --mem=12G

SM=$1

conda init bash
source ~/.bashrc
conda activate /home/rmacleod/scratch/apps/mambaforge/envs/map-etc

samtools merge -o ${SM}-U-ver15-FYBMJ-221021.libmerged.bam -@8 $(ls ${SM}*.merged.bam)

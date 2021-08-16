#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=debug
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=MAFFT
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vkakakiou@gmail.com

## Input files have .fasta extension

mafft --auto Genomes.fasta > Genomes_aligned.fasta


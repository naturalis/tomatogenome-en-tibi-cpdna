#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=debug
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=MUSCLE
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vkakakiou@gmail.com

cd /home/vasia.kakakiou/samtools/bin/FASTA/Extracted_markers

## Bash Script to loop MUSCLE
## Input files have .fasta extension

muscle -in *input*.fasta -out *output*.fasta 

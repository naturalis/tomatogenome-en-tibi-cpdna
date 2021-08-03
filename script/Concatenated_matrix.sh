#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=debug
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=concatenated_matrix
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vkakakiou@gmail.com

phyutility -concat -in ndhC-trnV_aligned.fasta ndhF_aligned.fasta petA-psbJ_aligned.fasta psbE-petL_aligned.fasta rbcL-accD_aligned.fasta rpl32-trnL_aligned.fasta rpoB-trnC_aligned.fasta rps16-trnQ_aligned.fasta trnH-psbA_aligned.fasta trnK_aligned.fasta trnS-trnG_aligned.fasta ycf1_aligned.fasta -out concatenated_matrix.nex

#!/bin/bash

phyutility -concat -in ndhC-trnV_aligned.fasta ndhF_aligned.fasta petA-psbJ_aligned.fasta psbE-petL_aligned.fasta rbcL-accD_aligned.fasta rpl32-trnL_aligned.fasta rpoB-trnC_aligned.fasta rps16-trnQ_aligned.fasta trnH-psbA_aligned.fasta trnK_aligned.fasta trnS-trnG_aligned.fasta ycf1_aligned.fasta -out concatenated_matrix.nex

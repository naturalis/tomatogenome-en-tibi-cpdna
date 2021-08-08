#!/bin/bash

cd /home/vasia.kakakiou/samtools/bin/FASTA/Extracted_markers

## Bash Script to loop MUSCLE
## Input files have .fasta extension

muscle -in *input*.fasta -out *output*.fasta 

#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=testing
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=PGDSpider_BCFtoFASTA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vkakakiou@gmail.com

cd /home/vasia.kakakiou/samtools/bin

## Bash Script to loop PGDSpider
## Input files have .bcf extension, output files .fasta. -Xmx5g indicates that java is allowed 5Gb memory.

for file in /home/vasia.kakakiou/samtools/bin/*.bcf
do
java -Xmx5g -jar /home/vasia.kakakiou/samtools/bin/PGD/PGDSpider2-cli.jar -inputfile "SRR1571027.pileup.bcf" -outputfile "SRR1571027.fasta" -inputformat BCF -outputformat FASTA-spid BCF_to_FASTA.spid
done
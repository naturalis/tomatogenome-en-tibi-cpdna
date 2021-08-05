#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --partition=debug
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#SBATCH --job-name=PGDSpider_BCFtoFASTA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=vkakakiou@gmail.com

cd /home/vasia.kakakiou/samtools/bin/PGD/

## Bash Script to loop PGDSpider
## Input files have .bcf extension, output files .fasta. -Xmx5g indicates that java is allowed 5Gb memory.

for file in /home/vasia.kakakiou/samtools/bin/Alignments/*.fasta
do
java -Xmx5g -jar /home/vasia.kakakiou/samtools/bin/PGD/PGDSpider2-cli.jar -inputfile "$file" -outputfile "${file%.fasta}.nexus" -inputformat FASTA -outputformat NEXUS -spid FASTA_to_NEXUS.spid
done
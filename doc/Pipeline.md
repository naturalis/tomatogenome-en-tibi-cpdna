# Pre-processing

## 0. Download _En Tibi_ tomato reads and accessions of 360 tomato resequencing project belonging to Latin America

    sratoolkit.2.10.8-ubuntu64/bin/./prefetch *accession_number*

## 1. Converting SRA files to forward and reverse reads

    fastq-dump -I --split-files *accession_number*

## 2. Quality assessment and trimming

	fastp \
                -i $IN1 \
                -I $IN2 \
                -o ${IN1}.qt \
                -O ${IN2}.qt \
                -j fastp.json -h fastp.html --verbose

# Assembly

## 3. Indexing the reads & reference

	# fw reads
        IN1=/fileserver/*accession_1*.fastq

        # rev reads
        IN2=/fileserver/*accession_2*.fastq

        # cpDNA fasta refseq, indexed with minimap2
        # https://github.com/naturalis/tomatogenome-en-tibi/blob/master/doc/Pipeline.md#3-indexing-the-reference
        REF=/fileserver/Solanum_lycopersicum_NC_007898.fasta

        # base name of the output file
        BASE=/fileserver/*accession*	

## 4. Paired-end mapping assembly

	minimap2 -ax sr -a -t 4 $REF \
	        ${IN1}.qt ${IN2}.qt | samtools view \
	       -b -u -F 0x04 --threads 4 -o ${BASE}.bam -

## 5. Sort by read name

    samtools sort -n -l 0 -m 3G --threads 4 \
	    -o ${BASE}.nsort.bam ${BASE}.bam

## 6. Correct mate pairs

    samtools fixmate -r -m  --threads 4 \
    	    ${BASE}.nsort.bam ${BASE}.fixmate.bam

## 7. Sort numerically

    samtools sort -l 0 -m 3G --threads 4 \
	    -o ${BASE}.sort.bam ${BASE}.fixmate.bam

## 8. Remove duplicates

	samtools markdup -r --threads 4 \
	        ${BASE}.sort.bam ${BASE}.markdup.bam

## 9. Create consensus sequence for each individual

       bcftools mpileup -Ou -f Solanum_lycopersicum_NC_007898.fa -o *accession_number*.pileup.bcf *accession_number*.markdup.bam

## 10. Convert BCF to FASTA

       cd /home/vasia.kakakiou/samtools/bin/PGD/

       for file in /home/vasia.kakakiou/samtools/bin/PGD/*.bcf
       do
       java -Xmx5g -jar /home/vasia.kakakiou/samtools/bin/PGD/PGDSpider2-cli.jar -inputfile "$file" -outputfile "${file%.bcf}.fasta" -inputformat BCF -outputformat FASTA -spid BCF_to_FASTA.spid
       done

## 11. Extraction of highly variable DNA markers/whole genomes

       fastafiles=$(ls *.fasta)

       for fasta in $fastafiles; do
       idseq=$(basename $fasta .pileup.fasta)
       extension=".markdup.bam"
       result="$idseq$extension"
       samtools faidx $fasta $result:*from_to_coordinates* -o ${idseq}.marker_name.fa
       done

## 12. Alignment

       #MUSCLE for DNA markers
       muscle -in *input*.fasta -out *output*.fasta 
       
       #MAFFT for whole genomes
       mafft --auto Genomes.fasta > Genomes_aligned.fasta

## 13. Convert FASTA to NEXUS

       cd /home/vasia.kakakiou/samtools/bin/PGD/

       for file in /home/vasia.kakakiou/samtools/bin/PGD/*.bcf
       do
       java -Xmx5g -jar /home/vasia.kakakiou/samtools/bin/PGD/PGDSpider2-cli.jar -inputfile "$file" -outputfile "${file%.fasta}.nex" -inputformat FASTA -outputformat NEXUS -spid FASTA_to_NEXUS.spid
       done

## 14. Concatenate alignments of DNA markers

       phyutility -concat -in ndhC-trnV_aligned.fasta ndhF_aligned.fasta petA-psbJ_aligned.fasta psbE-petL_aligned.fasta rbcL-accD_aligned.fasta rpl32-trnL_aligned.fasta rpoB-trnC_aligned.fasta rps16-trnQ_aligned.fasta trnH-psbA_aligned.fasta trnK_aligned.fasta trnS-trnG_aligned.fasta ycf1_aligned.fasta -out concatenated_matrix.nex

## 15. Network construction based on concatenated matrix & whole genomes

       PopART - Median Joining Network

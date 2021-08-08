## Bash Script to loop samtoolsfaidx
## Input files have .fasta extension

fastafiles=$(ls *.fasta)

for fasta in $fastafiles; do
idseq=$(basename $fasta .pileup.fasta)
extension=".markdup.bam"
result="$idseq$extension"
samtools faidx $fasta $result:*from_to_coordinates* -o ${idseq}.marker_name.fa
done

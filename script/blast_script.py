from Bio.Blast import NCBIWWW
from Bio import SeqIO
 
fasta_file = "query.fasta"           #load data
sequences = SeqIO.parse(fasta_file, "fasta")
for record in sequences:             #for each record in sequences
    print(record.id)                 #print record
    print(repr(record.seq))          #print representation
    print(len(record))               #print length
    result_handle = NCBIWWW.qblast("blastn", "nt", record.seq)  #run blastn
    with open("my_blast.xml", "a") as blast_file: # create and then append an xml output file
       blast_file.write(result_handle.read())

    result_handle.close() #tidy up

from Bio.Blast import NCBIXML

blast_records = NCBIXML.parse(result_handle) #parse xml
for blast_record in blast_records: #for each blast_record
    print("BLAST result for sequence:", blast_record.query)
    print("Number of alignments:", len(blast_record.alignments))
    print()

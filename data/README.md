Data
====

This directory contains sequence data in genbank and fasta format:

- [NC_007898.gb](NC_007898.gb) is the refseq record of the chloroplast genome of the tomato, in 
  GenBank file format. This version is useful because it provides the locations of genes on the
  genome (and strandedness, splicing, etc.)
- [NC_007898.fasta](NC_007898.fasta) contains the same data as the genbank file but in fasta 
  format. This is useful for mapping the *En Tibi* reads against.
- [query.fasta](query.fasta) contains the genes of the chloroplast genome as separate records in
  a fasta file. This is useful as input for BLAST searches to discover cpDNA markers at NCBI.
  
  Also, it contains the [pipeline] (Pipeline.md) of the whole analysis.

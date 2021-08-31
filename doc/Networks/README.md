Networks
===

This directory contains:

1. The list of tomato accessions used in the network analysis ([List_of_accessions.tsv](List_of_accessions.tsv))
2. The output of PopART v. 1.7 for both the concatenated matrix and the whole genomes ([Network_concatenated_regions.pdf](Network_concatenated_regions.pdf), [Network_genomes_regions.pdf](Network_genomes_regions.pdf))
3. The log files of the identical sequences of each node for both networks ([Concatenated_matrix_nodes.tsv](Concatenated_matrix_nodes.tsv), [Genomes_nodes.tsv](Genomes_nodes.tsv))
4. The final haplotype networks for both the concatenated matrix and the whole genomes after editing with CorelDRAW 2020 ([Network_concatenated_final.pdf](Network_concatenated_final.pdf), [Network_genomes_final.pdf](Network_genomes_final.pdf))

PopART analysis
-------------------

This step refers to operations on the files `concatenated_for_network.nex` and `Genomes_aligned_for_network.nex` in PopART v1.7 for Windows.

In PopART we select `nex` to import the alignment of the accessions along with the trait table in nexus format. From the window on the left we
check that the traits (regions in our case) are recognized correctly and the quality of the alignment. After that, we click on 'Network' and 
'Median Joining Network' (epsilon=0) to construct the haplotype networks.


Using the graphical interface, we reorient the graph and its terminal edges to reduce 
branch and label overlaps and optimize for landscape orientation of the main graph.
Exporting produces the files:

- `Network_concatenated_regions.pdf`
- `Network_genomes_species.pdf`

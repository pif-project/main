# Automated procedure for searching the PIF peptide into the human genome

- separate_genomes.pl: separate the human reference genome GRCh38 (https://www.ncbi.nlm.nih.gov/genome/guide/human/) into as many files as they are FASTA headers
- cds_finder.pl: find the coding sequences (CDS) on the 3 open reading frames, on the sense and antisense strands
- search_peptide.pl: search the query peptide into the CDS found

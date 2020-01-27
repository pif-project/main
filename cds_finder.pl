#!/usr/bin/env perl

use strict;
use warnings;

my $genome_file = $ARGV[0];

my $strand;
if ($ARGV[1] eq 'sense'){
    $strand = 'sense';
}
elsif ($ARGV[1] eq 'anti'){
    $strand = 'anti';
}
else{
    die "Error: invalid arg1 (sense or anti)\n";
}

my @genome_array;

my %hash_complement = load_complement();

if ($strand eq 'sense'){
    open (IN, '<', $genome_file) or die "Error: cannot read $genome_file\n";
    while (my $line = <IN>){
        #if ($line !~ m/^>/){
            chomp $line;
            my @nucleotides = split('', $line);
            foreach my $nucleotide (@nucleotides){
                push(@genome_array, $nucleotide);
            }
        #}
    }
    close IN;
}
else{
    open (IN, '<', $genome_file) or die "Error: cannot read $genome_file\n";
    while (my $line = <IN>){
        #if ($line !~ m/^>/){
            chomp $line;
            my @nucleotides = split('', $line);
            foreach my $nucleotide (@nucleotides){
                if (exists $hash_complement{uc($nucleotide)}){
                    unshift(@genome_array, $hash_complement{uc($nucleotide)});
                }
                else{
                    die "$nucleotide HAS NO COMPLEMENT\n";
                }
            }
        #}
    }
    close IN;
}

my %hash_genetic_code = load_genetic_code('standard');

translate_frame(0, \@genome_array, $genome_file, $strand);
translate_frame(1, \@genome_array, $genome_file, $strand);
translate_frame(2, \@genome_array, $genome_file, $strand);


sub translate_frame{
    my $frame = shift;
    my $genome_array_ref = shift;
    my $input_file_name = shift;
    my $strand = shift;

    my $protein_sequence = '';
    my $dna_sequence = '';
    my $codon = '';

    open (PROTOUT, '>', "$input_file_name.cds_$frame\_$strand\_prot") or die "Error: cannot write\n";
    open (DNAOUT, '>', "$input_file_name.cds_$frame\_$strand\_dna") or die "Error: cannot write\n";

    for (my $i=$frame; $i<=$#{$genome_array_ref}; $i++){
        $codon.=${$genome_array_ref}[$i];
        if (length($codon) == 3){
            my $residue = '';
            if (exists $hash_genetic_code{uc($codon)}){
                $residue = $hash_genetic_code{uc($codon)};
            }
            else{
                $residue = 'X';
            }

            if ($residue eq '_'){
                print PROTOUT "$protein_sequence\n";
                print DNAOUT "$dna_sequence\n";
                $protein_sequence = '';
                $dna_sequence = '';
            }
            else{
                $protein_sequence.=$residue;
                $dna_sequence.=$codon;
            }
            $codon = '';
        }
    }
    close PROTOUT;
    close DNAOUT;
}




sub load_complement{
    my %hash_output;

    %hash_output = (
    "A" => "T",
    "C" => "G",
    "G" => "C",
    "T" => "A",
    "W" => "W",
    "S" => "S",
    "M" => "K",
    "K" => "M",
    "R" => "Y",
    "Y" => "R",
    "B" => "V",
    "D" => "H",
    "H" => "D",
    "V" => "B",
    "N" => "N",
    );

    return %hash_output;
}







sub load_genetic_code{
    my $organism = shift;

    my %hash_output;

    if ($organism eq 'standard'){
        %hash_output = (
        "TTT" => "F",
        "TTC" => "F",
        "TTY" => "F",

        "TTA" => "L",
        "TTG" => "L",
        "TTR" => "L",

        "CTT" => "L",
        "CTC" => "L",
        "CTA" => "L",
        "CTG" => "L",

        "CTW" => "L",
        "CTS" => "L",
        "CTM" => "L",
        "CTK" => "L",
        "CTR" => "L",
        "CTY" => "L",
        "CTB" => "L",
        "CTD" => "L",
        "CTH" => "L",
        "CTV" => "L",
        "CTN" => "L",

        "ATT" => "I",
        "ATC" => "I",
        "ATA" => "I",
        "ATW" => "I",
        "ATM" => "I",
        "ATY" => "I",
        "ATH" => "I",

        "ATG" => "M",

        "GTT" => "V",
        "GTC" => "V",
        "GTA" => "V",
        "GTG" => "V",
        "GTW" => "V",
        "GTS" => "V",
        "GTM" => "V",
        "GTK" => "V",
        "GTR" => "V",
        "GTY" => "V",
        "GTB" => "V",
        "GTD" => "V",
        "GTH" => "V",
        "GTV" => "V",
        "GTN" => "V",

        "TCT" => "S",
        "TCC" => "S",
        "TCA" => "S",
        "TCG" => "S",
        "TCW" => "S",
        "TCS" => "S",
        "TCM" => "S",
        "TCK" => "S",
        "TCR" => "S",
        "TCY" => "S",
        "TCB" => "S",
        "TCD" => "S",
        "TCH" => "S",
        "TCV" => "S",
        "TCN" => "S",

        "CCT" => "P",
        "CCC" => "P",
        "CCA" => "P",
        "CCG" => "P",
        "CCW" => "P",
        "CCS" => "P",
        "CCM" => "P",
        "CCK" => "P",
        "CCR" => "P",
        "CCY" => "P",
        "CCB" => "P",
        "CCD" => "P",
        "CCH" => "P",
        "CCV" => "P",
        "CCN" => "P",

        "ACT" => "T",
        "ACC" => "T",
        "ACA" => "T",
        "ACG" => "T",
        "ACW" => "T",
        "ACS" => "T",
        "ACM" => "T",
        "ACK" => "T",
        "ACR" => "T",
        "ACY" => "T",
        "ACB" => "T",
        "ACD" => "T",
        "ACH" => "T",
        "ACV" => "T",
        "ACN" => "T",

        "GCT" => "A",
        "GCC" => "A",
        "GCA" => "A",
        "GCG" => "A",
        "GCW" => "A",
        "GCS" => "A",
        "GCM" => "A",
        "GCK" => "A",
        "GCR" => "A",
        "GCY" => "A",
        "GCB" => "A",
        "GCD" => "A",
        "GCH" => "A",
        "GCV" => "A",
        "GCN" => "A",

        "TAT" => "Y",
        "TAC" => "Y",
        "TAY" => "Y",

        "TAA" => "_",
        "TAG" => "_",

        "CAT" => "H",
        "CAC" => "H",
        "CAY" => "H",

        "CAA" => "Q",
        "CAG" => "Q",
        "CAR" => "Q",

        "AAT" => "N",
        "AAC" => "N",
        "AAY" => "N",

        "AAA" => "K",
        "AAG" => "K",
        "AAR" => "K",

        "GAT" => "D",
        "GAC" => "D",
        "GAY" => "D",

        "GAA" => "E",
        "GAG" => "E",
        "GAR" => "E",

        "TGT" => "C",
        "TGC" => "C",
        "TGY" => "C",

        "TGA" => "_",
        "TGG" => "W",

        "CGT" => "R",
        "CGC" => "R",
        "CGA" => "R",
        "CGG" => "R",
        "CGW" => "R",
        "CGS" => "R",
        "CGM" => "R",
        "CGK" => "R",
        "CGR" => "R",
        "CGY" => "R",
        "CGB" => "R",
        "CGD" => "R",
        "CGH" => "R",
        "CGV" => "R",
        "CGN" => "R",

        "AGT" => "S",
        "AGC" => "S",
        "AGY" => "S",

        "AGA" => "R",
        "AGG" => "R",
        "AGR" => "R",

        "GGT" => "G",
        "GGC" => "G",
        "GGA" => "G",
        "GGG" => "G",
        "GGW" => "G",
        "GGS" => "G",
        "GGM" => "G",
        "GGK" => "G",
        "GGR" => "G",
        "GGY" => "G",
        "GGB" => "G",
        "GGD" => "G",
        "GGH" => "G",
        "GGV" => "G",
        "GGN" => "G",
        );
    }

    return %hash_output;
}

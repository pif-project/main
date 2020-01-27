#!/usr/bin/env perl

use strict;
use warnings;

my @input_list = `cat $ARGV[0]`;
my $count = 0;
foreach my $line (@input_list){
    chomp $line;
    system "./cds_finder.pl $line anti";
    system "./cds_finder.pl $line sense";
    $count++;
    print "$count: $line\n";
}

#!/usr/bin/env perl

use strict;
use warnings;

my @input_list = `cat $ARGV[0]`;

my $count = 0;

foreach my $file (@input_list){
    chomp $file;
    my @array = `cat $file`;

    foreach my $line (@array){
        #if ($line =~ m/MEEPQSDPSVEPPLSQETFSDLWKL/){
        #if ($line =~ m/MPGFLVRILPLLLVLLLL/){
        #if ($line =~ m/NATQRMFEI/){
        #if ($line =~ m/SANKP/){
        if ($line =~ m/MVRIK/){
        #if ($line =~ m/PENNVLSPLPSQAMDDLML/){
            print STDERR "$file:\n$line\n";
        }
    }
    $count++;
    print "$count\n";
}

#!/usr/bin/env perl

use strict;
use warnings;

open (IN, '<', $ARGV[0]) or die "Error: cannot read $ARGV[0]\n";
while (my $line = <IN>){
    chomp $line;
    if ($line !~ m/^>/){
        print OUT "$line\n";
    }
    else{
        my ($filename, $foo) = split(' ', $line);
        $filename =~ s/^>//;
        open (OUT, '>', "$filename.txt") or die "Error: cannot write $filename.txt\n";
    }
}
close IN;
close OUT;

print "Done!\n";

#!/usr/bin/perl -w 
use strict;
use warnings;
while (<>) {
chomp;
if ($_ =~/^#/) {
print "$_\n";}
else {
my @col=split/\t/, $_;
my $col;
my @col8=split/;/, $col[7];
my $col8;
my @col83=split/=/, $col8[2];
my $col83;
my $len=$col83[1];
if ($len <= 5000000) {
print  "$_\n";
}
}
}


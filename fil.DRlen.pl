#!/usr/bin/perl -w 
use strict;
use warnings;
open(AA, "<$ARGV[0]") or die;
open (BB, ">>$ARGV[0].filDR.vcf") or die;
while (<AA>) { 
my $aa=$_;
chomp($aa);
if ($aa =~/^#/) {
print BB "$aa\n";}
else {
my @col=split/\|/, $aa;
my $col;
my @col2=split/=/, $col[0];
my $col2;
my $base=$col2[1];
my $len=length($base);
if ($len > 1) {
print BB "$aa\n";
}
}
}

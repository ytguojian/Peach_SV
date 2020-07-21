#!/usr/bin/perl -w 
use warnings;
use strict;
#This is used to convert the SV.vcf format to the same as SNP that can be used in GWAS .
#written by Jian Guo
#March 19, 2018
open (AA, ">>all.336.final.sort.maf0.01.convert.vcf")or die;
`head -500 all.336.final.sort.maf0.01.recode.vcf >a.vcf`;
open (CC, "<a.vcf")or die;
while (<CC>) {
chomp;
if (/^#/) {
print AA "$_\n";
}
}
open (BB, "<all.336.final.sort.maf0.01.recode.vcf.simply")or die;
while (<BB>) {
my $line1=$_;
chomp($line1);
my @col=split/\t/, $line1;
my $col;
print AA "$col[0]\t$col[1]\t\.\t0\t1\t\.\tPASS\t\.\tGT\t";
for (my $i=4;$i<=339;$i+=1) {
print AA "$col[$i]\t";
}
print AA "\n";
}
`rm a.vcf`;

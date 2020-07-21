#!/usr/bin/perl -w 
use strict;
use warnings;
open(AA, "<$ARGV[0]") or die;
open (BB, ">>$ARGV[0].1") or die;
`ls $ARGV[0] >$ARGV[0].tem`;
open(CC, "<$ARGV[0].tem") or die;
while (<CC>) {
my $cc=$_;
chomp($cc);
my @colcc=split/\./, $cc;
my $colcc;
print BB "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tsample$colcc[0]\n";
}
my $i=0;
while (<AA>) {
my $aa=$_;
chomp($aa);
if ($aa !~ /^Chr/){
$i+=1;
my @colaa=split/\t/, $aa;
my $colaa;
print BB "$colaa[0]\t$colaa[2]\tTE$i\tN\tTE\t\.\tPASS\tTEINFO=$colaa[4]|$colaa[3]|$colaa[6]|$colaa[8]|$colaa[9]\tGT\t$colaa[1]\n";
}}
`cat header $ARGV[0].1 >$ARGV[0].vcf`;
`rm $ARGV[0].1 $ARGV[0].tem`;

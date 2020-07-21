#!/usr/bin/perl -w
use warnings;
use strict; 
die "Usage:perl $0 <filteredTE> <xx.depth>\n" unless (@ARGV==2);
##This script is used to filter the TE generated from panISa software. Any TEs that have ge 5 & le 30 End clipped reads or Start clipped reads and also have a position depth le 50 were kept ;and genotype according to the depth of TE position by comparing the cliped reads count and position depth;
#Further re-genotype the TE based on the result of fil.depth.pl. Because the depth file getting from not make deduplication with picard, so the depth is not correct, it is much larger than the clipped reads number.So, I just re-calculate the depth with .sorted.dedup.bam, Then genotype each site according the reads number of clipped reads and depth(standard:+-2); 
open(DD, "<$ARGV[0]") or die; #original TE result
open(EE, ">>$ARGV[0].filt.tem") or die;
open(FF, ">>$ARGV[0].final.txt") or die;
while (<DD>) {
my $dd=$_;
chomp($dd);
if ($dd =~ /^Chr/) {
print EE "$dd\n";}
else {
my @coldd=split/\t/,$dd;
my $coldd;
my $repeat=$coldd[4];
my $endclip=$coldd[3];
my $startclip=$coldd[6];
my $total=$endclip+$startclip;
if (($repeat =~ /[AGCT]+/) && ($total >=8) &&($total <=30)) {
print EE "$dd\n";}
}}

print "###############step1 finished\n";
close EE;
##############################################################################################################################
#filter based on the depth le 50 and genotype
open (BB, "<$ARGV[0].filt.tem") or die;
while (<BB>){ 
my $line1=$_;
chomp($line1);
if ($line1 =~ /^Chr/) {
print FF "Chromosome\tGT\tEnd position\tEnd clipped reads\tDirect repeats\tStart position\tStart clipped reads\tInverted repeats\tLeft sequence\tRight sequence\n";
}
else {
my @col=split/\t/,$line1;
my $col;
my $chr=$col[0];
my $pos=$col[2];
my $totalclip=$col[3] + $col[6];
my $aa=`grep -w '$chr' $ARGV[1] |grep -w '$pos'`;
chomp($aa);
my @col2=split/\t/,$aa;
my $col2;
my $chr2=$col2[0];
my $pos2=$col2[1];
my $dep=$col2[2];
my $depleft=$dep-2;
my $depright=$dep+2;
#my $halfdep=$dep/2;
#my $halfdepright=$halfdep+4;
if  ($dep <= 50) {
if  (($totalclip >= $depleft)&&($totalclip <= $depright)) { #||( ($dep <= 50) && ($totalclip <=$depright))) {
print FF  "$col[0]\t1\/1\t$col[2]\t$col[3]\t$col[4]\t$col[5]\t$col[6]\t$col[7]\t$col[8]\t$col[9]\n";
}
else {
print FF "$col[0]\t0\/1\t$col[2]\t$col[3]\t$col[4]\t$col[5]\t$col[6]\t$col[7]\t$col[8]\t$col[9]\n";}
}
}}
`rm $ARGV[0].tem $ARGV[0].filt.tem`;

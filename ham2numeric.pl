#!/usr/bin/perl -w
use warnings;use strict;
die "please input <samplename> <hapmapfile>" unless @ARGV==2;
open(AA, "<$ARGV[0]") or die;#samplename
#open(BB,"<$ARGV[1]") or die;#ham file
open(OUT, ">>$ARGV[1].numeric.txt") or die;

my @aa=<AA>;
my $aa;
my $i=11;
foreach $aa (@aa) {
chomp($aa);
print OUT "$aa\t";
open(BB,"<$ARGV[1]") or die;#ham file
while (<BB>) {
chomp(my $linebb=$_);
if ($linebb =~ /^snp/) {
my @col=split/\t/,$linebb;
my $col;
	if (($col[$i] eq "00") ||($col[$i] eq "NN")) {
	print OUT "0\t";}
	elsif ($col[$i] eq "01") {
	print OUT "1\t";}
	elsif ($col[$i] eq "11") {
	print OUT "2\t";}
}}
print OUT "\n";
$i+=1;
close BB;
}

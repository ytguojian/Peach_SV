#!/usr/bin/perl -w
use strict;
use warnings;
open(AA, "<$ARGV[0]") or die;#all.SV.INDEL.maf0.01.convert.vcf,will be changed the common site position
open(NN, ">Change.Times") or die;
my $n=0;
while (<AA>) {
my $aa=$_;
chomp($aa);
if ($aa =~ /^Pp0/) {
my @col=split/\t/, $aa;
my $col;
my $chr=$col[0];
my $pos=$col[1];
`grep -w '$chr' $ARGV[1]|grep -w '$pos' >$ARGV[1].tem`;##TE file
my $a=`ls -l $ARGV[1].tem`;
chomp($a);
my @cc=split/ /, $a;
my $cc;
my $pp=$cc[4];
if ($pp > 0 ) {
$n+=1;
my $pos2=$pos+1;
print "$col[0]\t$pos2\t";
for (my $i=2;$i<=344;$i+=1) {
print "$col[$i]\t";
}
print "\n";
}
else {
print "$aa\n";}

}
}
print NN "$n\n";


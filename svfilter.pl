#!/usr/bin/perl -w
#This is used for filtering in three aspects. 1: to filter QUAL score less than 20; 2: to filter  DELs which are less than 340 bp and have no SR supports; 3: to filter BND with QUAL >100.
#Written by Jian Guo
#Jan 26, 2018
use strict;
use warnings;
die "Usage:perl $0 \nPlease input one file and one name  <originalfile> <filterfilename>\n" unless (@ARGV==2);
open (AA, "<$ARGV[0]")  or die "$!";
open (BB, ">>$ARGV[1]") or die "$!";
while (<AA>) {
chomp;
if ( /^#/ ) {

print BB "$_\n";
}
elsif ((/(\S+\t){5}(\d+)(.+)SVTYPE=(\S{3});SVLEN(.+)/) && ($2 > 20) && ( $4 ne "DEL" )) {
print BB "$_\n";
}
elsif ((/(\S+\t){5}(\d+)(.+)SVTYPE=(\S{3});STRANDS(.+)/) && ($2 > 100) && ( $4 eq "BND" )){
print BB "$_\n";
}
elsif ((/(\S+\t){5}(\d+)(.+)SVTYPE=(\S{3});SVLEN=-(\d+);(.+)SR=(\d+);/) && ($2 > 20) && ( $4 eq "DEL" ) && ( $5 < 340 ) && ( $7 > 0 ) ) {
print BB "$_\n";
}
elsif ((/(\S+\t){5}(\d+)(.+)SVTYPE=(\S{3});SVLEN=-(\d+);(.+)SR=(\d+);/) && ($2 > 20) && ( $4 eq "DEL" ) && ( $5 > 340 ) ) {
print BB "$_\n";
}
}

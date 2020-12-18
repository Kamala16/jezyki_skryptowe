#!/usr/bin/perl
# Aleksandra Chrzanowska grupa 2

use Switch;

my $start = time;

$catWithWithout=0;
$catWithNumber=0;
$catWithoutComm=0;
$catNewNumber=0;

while($#ARGV >= 0){
    switch($ARGV[0]) {
        case "-c" {
            $catWithNumber=1;
            shift;
        }
        case "-N" {
            $catWithoutComm=1;
            shift;
        }
        case "-n" {
            $catWithWithout=1;
            shift;
        }
        case "-p" {
            $catNewNumber=1;
            shift;
        }
        else{
            if($catWithNumber){
                while (<>)  { print "$. $_"}
            }elsif($catWithoutComm){
                while (<>) { print "$_" unless (/^#/)}
            }elsif($catWithWithout){
                while (<>) { print "$. $_" unless (/^#/)}
            }elsif($catNewNumber){
                while (<>) {
                    print "$. $_";
                } continue {
                    close ARGV if eof;
                }
            }else{
                while (<>) { print "$_"};
            }
            shift;
        }
    }
}
my $end = time - $start;
print "Czas działania: $end\n";
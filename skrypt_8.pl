#!/usr/bin/perl
#Aleksandra Chrzanowska grupa 2

$splitString=shift;
$splitString=quotemeta($splitString);
$first=shift;
$last=shift;

if($first !~ /^[+-]?\d+$/ || $last !~ /^[+-]?\d+$/){
    print("Argument nie jest liczbą całkowitą");
    exit 1;
}

while($#ARGV >= 0){
    if(open my $in, "<", shift){
        while (<$in>) {
            my @line=split($splitString);
            @line[$first-1] =~ s/^\s+|\s+$//g;
            @line[$last-1] =~ s/^\s+|\s+$//g;
            print (@line[$first-1]);
            print ("\n");
            print (@line[$last-1]);
            print ("\n");
        }
    } else {
        print STDERR "Błąd odczytu pliku\n";
    }
}

#!/usr/bin/perl
#Aleksandra Chrzanowska grupa 2

$first=shift;
$last=shift;

if($first !~ /^[+-]?\d+$/ || $last !~ /^[+-]?\d+$/){
    print("Argument nie jest liczbą całkowitą");
    exit 1;
}

while($#ARGV >= 0){
    if(open my $in, "<", shift){
        while (<$in>) {
            my @line=split;
            print (@line[$first-1]);
            print ("\n");
            print (@line[$last-1]);
            print ("\n");
            # undef @line;
        }
        # shift;
    } else {
        print STDERR "Błąd odczytu pliku\n";
    }
}
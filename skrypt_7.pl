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

if($first > $last) {
    $temp=$first;
    $first=$last;
    $last=$temp;
}

while($#ARGV >= 0){
    if(open my $in, "<", shift){
        while (<$in>) {
            my @line=split("$splitString");
            for (my $i=$first-1; $i<$last; $i++){
                @line[$i] =~ s/^\s+|\s+$//g;
                print(@line[$i]);
                print("\n");
            }
        }
    } else {
        print STDERR "Błąd odczytu pliku\n";
    }
}
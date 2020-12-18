#!/usr/bin/perl
#Aleksandra Chrzanowska grupa 2

$first=shift;
$last=shift;

if($first !~ /^[+-]?\d+$/ || $last !~ /^[+-]?\d+$/){
    print("Argument nie jest liczbą całkowitą");
    exit 1;
}

# print STDERR "Błąd odczytu pliku\n" if($@);
# print($@);

if($first > $last) {
    $temp=$first;
    $first=$last;
    $last=$temp;
}

while($#ARGV >= 0){
    if(open my $in, "<", shift){
        while (<$in>) {
            my @line=split;
            print join("\n", @line[$first-1..$last-1]);
            # undef @line;
        }
        print("\n");
        # shift;
    } else {
        print STDERR "Błąd odczytu pliku\n";
    }
}


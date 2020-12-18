#!/usr/bin/perl
# Aleksandra Chrzanowska grupa 2

package SprawdzenieLiczb;

sub ifNumber{
    my $number=shift;
    if ($number =~ /^[+-]?[0-9]+(\.[0-9]+)?([eEqQdD]|\^[0-9]+(\.[0-9]+)?)?$/){
        return 1;
    }else{
        return 0;
    }
}

sub ifInteger{
    my $number=shift;
    if ($number =~ /^[+-]?\d+$/){
        return 1;
    }else{
        return 0;
    }
}

1;
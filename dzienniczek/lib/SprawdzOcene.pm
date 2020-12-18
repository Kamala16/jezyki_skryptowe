#!/usr/bin/perl
# Aleksandra Chrzanowska grupa 2

package SprawdzOcene;

sub poprawnaOcena {
    my $ocena=shift;
    if($ocena =~ /^[+-]?[0|2-6](\.[0-9]*)?[+-]?/){
        if($ocena =~ /^(\-[2])|([2]\-)|(\+[6])|([6]\+)|([0]+\.[0-9]*)|([+-][2-6]+\.[0-9]+)|([2-6]+\.[0-9]+[+-])|([+-]?[0-9][0-9][+-]?)/){
            return 0;
        }
        return 1;
    }else{
        return 0;
    }
}

1;
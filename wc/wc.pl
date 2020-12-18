#!/usr/bin/perl
# Aleksandra Chrzanowska grupa 2

use strict;
use warnings;

use Switch;
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname (abs_path $0).'/lib';

use SprawdzenieLiczb;

my $dowolneLiczby=0;
my $liczbyCalkowite=0;
my $opuscKomentarz=0;

my $sumaLini=0;
my $sumaSlow=0;
my $sumaBajtow=0;
my $sumaLiczb=0;

my $iloscPlikow=0;

if($#ARGV < 1){
    print("za mało alrgumentów\n");
}

while($#ARGV >= 0){
    switch($ARGV[0]){
        case "-d"{
            $dowolneLiczby=1;
            shift;
        }
        case "-i"{
            $liczbyCalkowite=1;
            shift;
        }
        case "-e"{
            $opuscKomentarz=1;
            shift;
        }
        else{
            if(open my $in, "<", shift){
                chomp($in);
                $iloscPlikow++;
                if($dowolneLiczby){
                    my $iloscLiczb=0;
                    my $zakomentowanych=0;
                    while (my $line = <$in>) {
                        if($opuscKomentarz){
                            if ($line =~ m/^#/){
                            }else{
                                foreach my $j (split /\s+/, $line){
                                    # if ($j =~ /^[+-]?[0-9]+(\.[0-9]+)?([eEqQdD]|\^[0-9]+(\.[0-9]+)?)?$/){
                                    #     $iloscLiczb++;
                                    # }
                                    $iloscLiczb += SprawdzenieLiczb::ifNumber($j);
                                }
                            }
                        }else{
                            foreach my $j (split /\s+/, $line){
                                # if ($j =~ /^[+-]?[0-9]+(\.[0-9]+)?([eEqQdD]|\^[0-9]+(\.[0-9]+)?)?$/){
                                #     $iloscLiczb++;
                                # }
                                $iloscLiczb += SprawdzenieLiczb::ifNumber($j);
                            }
                        }
                    } 
                    $sumaLiczb+=$iloscLiczb;
                    print("ilość liczb: ", $iloscLiczb, "\n");
                }elsif($liczbyCalkowite){
                    my $iloscLiczb=0;
                    my $zakomentowanych=0;
                    while (my $line = <$in>){
                        if($opuscKomentarz){
                            if ($line =~ m/^#/){ 
                            }else{
                                foreach my $j (split /\s+/, $line){
                                    # if ($j =~ /^[+-]?\d+$/){
                                    #     $iloscLiczb++;
                                    # }
                                    $iloscLiczb += SprawdzenieLiczb::ifInteger($j);
                                }
                            }
                        }else{
                            foreach my $j (split /\s+/, $line){
                                # if ($j =~ /^[+-]?\d+$/){
                                #     $iloscLiczb++;
                                # }
                                $iloscLiczb += SprawdzenieLiczb::ifInteger($j);
                            }
                        }
                    }
                    $sumaLiczb+=$iloscLiczb;
                    print("ilość liczb całkowitych: ", $iloscLiczb, "\n");
                }else{
                    my $iloscLini=0;
                    my $iloscSlow=0;
                    my $iloscBajtow=0;

                    while (my $line = <$in>){
                        $iloscLini++;
                        foreach my $str (split /\s+/, $line){
                            $iloscSlow++;
                        }
                    }
                    $iloscBajtow = -s $in;
                    
                    $sumaLini += $iloscLini;
                    $sumaSlow += $iloscSlow;
                    $sumaBajtow += $iloscBajtow;

                    print("ilość lini: ", $iloscLini, "\n");
                    print("ilość słow: ", $iloscSlow, "\n");
                    print("ilość bajtów: ", $iloscBajtow, "\n");
                }
            }else{
                print STDERR "Błąd odczytu pliku\n";
            }
        }
    }
}
if($iloscPlikow > 1){
    if($dowolneLiczby){
        print("suma liczb: ", $sumaLiczb, "\n");
    }elsif($liczbyCalkowite){
        print("suma liczb całkowitych: ", $sumaLiczb, "\n");
    }else{
        print("suma lini: ",$sumaLini, "\n");
        print("suma słow: ",$sumaSlow, "\n");
        print("suma bajtów: ",$sumaBajtow, "\n");
    }
}
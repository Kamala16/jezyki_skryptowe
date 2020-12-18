#!/usr/bin/perl
#Aleksandra Chrzanowska grupa 2

use bignum ( p => -2 );
use English '-no_match_vars';
use File::Basename qw(dirname);
use Cwd qw(abs_path);
use lib dirname (abs_path $0).'/lib';

use SprawdzOcene;

sub wartosc {
    my $ocena=shift;
    if($ocena =~ /^[+]([2-5])|([2-5])[+]/){
        return $1+0.25;
    }elsif($ocena =~ /^[-]([3-6])|([3-6])[-]/){
        return $1-0.25;
    }else{
        return $ocena;
    }
}

if($#ARGV < 0){
    print("Za mała ilość argumentów\n")
}

while($#ARGV >= 0){
    if(open my $in, "<", my $plik=shift){
        my %dziennik;
        my $numberOfLine=0;
        while(my $line = <$in>){
            $numberOfLine++;
            if($line =~ /^[a-z|A-Z]* [a-z|A-Z]* [+-]?[0-9]*[+-]?/){
                my @oneLine;
                foreach my $j (split /\s+/, $line){
                    push(@oneLine, $j);
                }
                my $imie=@oneLine[0];
                my $nazwisko=@oneLine[1];
                my $ocena=@oneLine[2];
                if(SprawdzOcene::poprawnaOcena($ocena) == 1){
                    $imie=ucfirst(lc($imie));
                    $nazwisko=ucfirst(lc($nazwisko));
                    unless(defined($dziennik{"$nazwisko $imie"})){
                        my @oceny;
                        $dziennik{"$nazwisko $imie"}=[];
                    }
                    push(@{$dziennik{"$nazwisko $imie"}}, $ocena);                
                }else{
                    print STDERR ("Błędna ocena: ", $plik, " ". $numberOfLine, " ", $line, "\n");
                }               
            }else{
                print STDERR ("Nie udalo się odczytac lini: ", $plik, " ". $numberOfLine, " ", $line, "\n");
            }
            undef @oneLine;
        }
        my $sumaSrednich;
        my $size= keys %dziennik;
        my $filename="$plik.oceny";
        open(my $fh,'>', $filename) or die "Nie mozna otworzyc pliku '$filename' $!";
        foreach my $name (sort keys %dziennik){
            my $suma;
            my $length=@{$dziennik{$name}};
            foreach my $i (@{$dziennik{$name}}){
                print(wartosc($i), "\t");
                $suma+=wartosc($i);
                print($suma, "\n");
            }
            my $srednia=$suma/$length;
            $sumaSrednich+=$srednia;
            $OUTPUT_FIELD_SEPARATOR = ' ';
            print $fh ("Nazwisko Imię:", $name, "\tLista ocen:", @{$dziennik{$name}}, "\tŚrednia:", $srednia, "\n");
        }
        my $sredniaSrednich=$sumaSrednich/$size;
        print $fh ("\n"); 
        print $fh ("Średnia całego pliku: ", $sredniaSrednich, "\n");
        close $fh;
    }else{
        print STDERR "Błąd odczytu pliku\n";
    }
    undef %dziennik;
    undef $numberOfLine;
}
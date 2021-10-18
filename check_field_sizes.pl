#!/usr/bin/perl

use Getopt::Std;
getopts('dhs:i:') or die "bad options: $!";
if ($opt_s) {
    $sep = $opt_s;
} else {
    $sep = "\t";
}
$useheader = $opt_h;
if ($opt_i) {
    open INFILE, "<$opt_i" or die "can't open input file: $!\n";
} else {
    die "must specify file name\n";
}

if ($useheader) {
    # read in the first line
    $headerline = <INFILE>;
    # split it into an array by commas
    $headerline =~ s/[\"\n\r\f]//g;
    @header = split /$sep/, $headerline;
    
    #read in the second line
    $second = <INFILE>;
    
    # split it into an array
    $second =~ s/[\"\r\n\f]//g;
    @types = split /$sep/, $second;
    @terms = split /$sep/, $second;
    
} else {
    # read in the first line
    $first = <INFILE>;
    # split it into an arry by commas
    $first =~ s/[\"\r\n\f]//g;
    @types = split /$sep/, $first;
    @terms = split /$sep/, $first;;
}

# count the number of fields 
$fields = $#terms + 1;

# check if each element is numerical or character
for ($i = 0; $i < $fields; $i++) {
    # print $i, " ", $header[$i], "\n";
    if ($types[$i] =~ /^\s*\d*\s*$/) {
	$field_type[$i] = "I";
    } elsif ($types[$i] =~ /^\s*\d*\.(\d+)\s*$/) {
	$field_type[$i] = length($1);
    } else {
	$field_type[$i] = "V";
    }
    # print $i, " ", $header[$i], " ", $types[$i], " ", $field_type[$i], "\n";
}

# measure the length of each field

@maxlengths = map length, @terms;

# start looping through file:
while(<INFILE>) {
    $_ =~ s/B\,R\"/B\;R/g;
    $_ =~ s/[\"\r\n\f]//g;
    @terms = split /$sep/, $_;
    @lengths = map length, @terms;
    for ($i = 0; $i < $fields; $i++) {
	if ($lengths[$i] > $maxlengths[$i]) {
	    if ($opt_d) {print "new max pos $i: $terms[$i]\n";}
	    $maxlengths[$i] = $lengths[$i];
	}
	if ($terms[$i] !~ /^\s*[\d,\.]*\s*$/) {
	    if (($opt_d) and ($field_type[$i] ne "V")) {
		print "changing field type for $header[$i]: \"$terms[$i]\"\n";
 		print "\t$_\n\t";
 		print join ",", @terms;
 		print "\n";
	    }
	    $field_type[$i] = "V";
	}
    }
}
close(INFILE);

if ($opt_i =~ /([\w|\.]*)\.\w+$/) {
    $tablename = $1;
    $tablename =~ s/\.//;
} elsif ($opt_i =~ /.*\/([\w|\.]*)\.\w+$/) {
    $tablename = $1;
    $tablename =~ s/\.//;
} else {
    $tablename = "NONAMETABLE";
}

print "CREATE TABLE $tablename (\n";
for ($i = 0; $i < $fields; $i++) {
    if ($useheader) {
	$varname = $header[$i];
    } else {
	$varname = "variable$i";
    }
    if ($field_type[$i] =~ /I/ and $maxlengths[$i] < 6) {
	print "\t$varname SMALLINT($maxlengths[$i])";
    } elsif ($field_type[$i] =~ /I/) {
	print "\t$varname INTEGER($maxlengths[$i])";
    } elsif ($field_type[$i] =~ /V/ and $maxlengths[$i] > 255) {
	print "\t$varname TEXT";	
    } elsif ($field_type[$i] =~ /V/) {
	print "\t$varname VARCHAR($maxlengths[$i])";	
    } else {
	print "\t$varname DECIMAL($maxlengths[$i],$field_type[$i])";
    }
    if ($i + 1 == $fields) {
	print "\n);\n";
    } else {
	print ",\n";
    }
}

print ";\n";

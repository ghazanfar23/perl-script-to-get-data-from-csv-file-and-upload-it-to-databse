#!/opt/local/bin/perl

# section_number is key match for class_num in CougarNet

use Time::Local;

use Date::Parse;
use Date::Language;
use POSIX qw(strftime);
use Date::Parse;
use DBI;
use Getopt::Long;
use strict;


my ($verbose, $update, $local, $production);
GetOptions ("verbose|v"  => \$verbose, "update|u"=>\$update, "help|h"=>\&help, "local|l"=>\$local, "production|p"=>\$production);

# Database
my $db_database = '';
my $db_user = '';
my $db_pass = '';
my $db_host = '';
my $db_port = '';
my $url     = '';
my $key;


if ($local) {
    # Local
    $db_host = '';
    $db_port = '';
}

if ($production) {
    $db_database = '';
}



our %header;
sub get_header(){
	my (@line) = @_;
	#get the header and store a reference
	my $lp=0;
	foreach (@line){
		$_=~s/\.//g;
		$_=~s/\W/_/g;
		$header{lc($_)} = $lp;
		$lp++;
	}
}

sub get_column_number(){
	my ($col) = @_;
	return $header{$col};
}

my $filename = ""; 

open (my $input, $filename) or die "couln't open the file";

my @file_data;

while (my $line = <$input>){

     chomp $line;

     push (@file_data, $line);
}

close $input;

my $lp=0;
my $errors=0;
foreach my $c(@file_data){
	$c=~s/^\"|\"$//g;
	my @line = split(/\",\"/,$c);

	#clean line for insert into database
	for(my $i=0; $i < @line; $i++){
		my $clean = $line[$i];
		$clean=~s/\'/\\'/g;
		$clean=~s/^\s+$//;
		$line[$i]=$clean;
	}

	if ($lp == 0){
		&get_header(@line);
		$lp++;
		next;
	}

#put the field name and variable where you save that field name. (I put values in first hash do ot for all of them.)
my %data = (

		"variable here"=>($line[&get_column_number('field name here')] ? "'$line[&get_column_number('variable here')]'" : "NULL"),
		""=>($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""=>($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""=>($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""=>($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""=>($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),

		""	=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""	=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		"" => ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		"" 		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		
		""=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		""		=> ($line[&get_column_number('')] ? "'$line[&get_column_number('')]'" : "NULL"),
		
        );
		
		#validation function call put the same values from function
		
		if (validation($data{put function here}, "string")){
	
        next;
		
	    } 
		
		if (validation($data{}, "string")){
	
        next;
		
	    }  if (validation($data{}, "integer")){
	
        next;
		
	    }  if (validation($data{}, "integer")){
	
        next; 
		
		}
		if($verbose){
		print "-PROCESS: Processing Article \r\n";
		
	}

if($update){
my $sql = "replace into xxxxxx set
	put database field name here=$data{put field from file you are using},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{''},
	=$data{''},
	=$data{''},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
	=$data{},
    =$data{},
	=$data{}";
	
if($verbose){
				print "-INFO: Inserting courses collected \n";
				print "\t-SUCCESS: $sql \n"; 
			}

else{
			if($verbose){
				print "\t-ERROR:\n";
			}

     }
  }
 
sub help(){
	print "$0 [-v|--verbose] [-u|--update] [-h|--help] \n";
	exit;
    }

#validation function
sub validation(){
     my $data = shift;
	 my $type = shift;

	#looking if data is available 
	if (!defined $data){
	   return 1;
	   
	}
	
    if ($data eq ""){
	   print "undefined \n";
	   return 1;
	}
	
	#specifically for integers
   
      
	
	#specifically for strings
	
	if ($type eq "string"){

	   if($data =~ /[^\w \:\;\-\#\&\(\)\"\'\?\.\,\/\\'s\+]/){
	   print "invalid characters: $data \n";
	   return 1;
	   
	   }

     }
	 if ($type eq "integer"){
     
      if ($data !~ /[[0-9]/){
	  print "no integer data found: $data \n";
	  return 1;
	  }
	  } 
	
   }
}

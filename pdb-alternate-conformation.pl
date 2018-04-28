#!/usr/bin/perl

print "Enter the PDB Filename:";
$fname=<STDIN>;
chomp($fname);

print "Enter the required Conformation(A or B):";
$choice=<STDIN>;
chomp($choice);

$i=0;
open (FILE, "<$fname.pdb") or die "an error occured: $!";
@lines = <FILE>;

$filename=$fname.$choice;
@new=@lines;

foreach $line (@lines) 
       { 
       if ($line =~ /^ATOM(.*)|^HETATM(.*)/ig)
  	  {
          $alt=substr($line,16,1);
          if ($alt =~ /$choice/ig)
             {
	     $i++;
             }
          }	
       }       
close(FILE);
if ($i > 0)
   {
   open (MYOUTFILE, ">$filename.pdb");
   foreach $lin (@new) 
       { 
       if ($lin =~ /^ATOM(.*)|^HETATM(.*)/ig)
  	  {
          $alt=substr($lin,16,1);
          if ($alt =~ /\s|$choice/ig)
             {
	     $i++;
	     print MYOUTFILE "$lin";
             }
          }	
       }       
   }
else
   {
   print "The file $fname.pdb does not contains alternate conformation\n";
   }   
close(MYOUTFILE);

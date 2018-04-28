#!/usr/bin/perl
#This code is used for identifying and spliting alternate conformations in a given PDB file. (If a PDB file contains alternate conformation.)
#The chosen conformation is written out as a separate output file
#The code can be run in an interactive mode in Linux shell or Cygwin

#Example format: 6LYZ or 6lyz (The pdb file 6LYZ.pdb or 6lyz.pdb should be available in the current working directory to get accurate results)
print "Enter the Four Letter Code of PDB Filename (case sensitive):";
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

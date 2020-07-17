use strict;
use warnings;

#SAVE A CONTACT

sub save {
print "\n";
open FH, ">> contacts.txt" or die $!;
print "Enter contact details below:","\n";
print "\n","Name: ";
chomp (my $name=<STDIN>);
print "Address: ";
chomp (my $address=<STDIN>);
print "Contact number: ";
chomp (my $contact=<STDIN>);
print "Email ID: ";
chomp (my $email=<STDIN>);
print FH "$name,$address,$contact,$email","\n";
print "\n","Contact saved succesfully.","\n";
close FH;
instr1();
}

#VIEW A CONTACT (Search by name)

sub view {
open FH, "< contacts.txt" or die $!;
print "\n";
print "Enter name to search: ";
my $name=<STDIN>;
chomp $name;
my $count=0;
    
while (my $line = <FH>) {
my @linedata= (split ',', $line);
my $first= $linedata[0];
if ($first=~m/$name/i){ 
$count++;
print "\n";
print "Name:","\t","\t",$first,"\n";
print "Address:","\t",$linedata[1],"\n";
print "Contact:","\t",$linedata[2],"\n";
print "Email ID:","\t",$linedata[3],"\n";
print "\n";
}
}
print "Found $count result(s).","\n";
instr1();
close FH;
}

#INTERFACE FOR SELECTING AN OPTION (View/Save/Exit)

sub instr1 {
print "\n";
print "Options Available: (1: View a contact, 2: Save, 3: Exit)","\n" ,"What do you want to do?: ";
my $entry=<STDIN>;
if ($entry==1) {view();}
elsif ($entry==2) {save();}
elsif ($entry==3) {exit;}
else {
print "Enter a valid request.","\n";
instr1();
}
}

#WELCOME MESSAGE

print "\n","Welcome to CONTACT BOOK!","\n";
instr1();


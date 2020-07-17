use strict;
use warnings;

sub user {
print "\n", "Please enter your details below.","\n";
print "Name: ";
chomp (my $name=<STDIN>);
print "Email ID: ";
chomp (my $email=<STDIN>);


print "\n", "Enter 1 to start the test: ";
chomp (my $entry=<STDIN>);
while ($entry!=1) {
print "Not a valid request.","\n";
print "Enter 1 to start the test: ";
chomp ($entry=<STDIN>);
}

#STARTING THE TEST

my $ques_num=0;
my $score=0;
open FH, "< questions.txt" or die $!;

while (my $line = <FH>) {
if ($line=~ /^$/) {
next;
}
else {
my @ques= (split ',', $line);
print "\n";
++$ques_num;

print "************************************************************************","\n";
print "QUESTION NUMBER $ques_num","\n";
print "************************************************************************","\n";
print "\n","Question: ",$ques[0],"\n";
print "A: ",$ques[1],"\n";
print "B: ",$ques[2],"\n";
print "C: ",$ques[3],"\n";
print "D: ",$ques[4],"\n";
print "\n", "Enter your answer: ";
chomp (my $user_ans=<STDIN>);
my $option=$ques[5];
if ($user_ans=~m/[$option]/i) {
$score++;
print "Correct Answer!","\n";
}
else {
print "Incorrect! The correct answer is $option", "\n";
}
}
}
close FH;
my $percent=($score / $ques_num) * 100;
print "\n","Your Score: $score/$ques_num ($percent%).","\n";
open FH, ">> users.txt" or die $!;
print FH "$name,$email,$score/$ques_num,$percent%","\n";
close FH;
print "Thank you for giving the test!","\n";
}

sub admin_login {
print "\n", "Please enter your credentials below.","\n";
print "Username: ";
chomp (my $username=<STDIN>);
print "Password: ";
chomp (my $password=<STDIN>);
my $string="$username,$password";
open FH, "< admin.txt" or die $!;
chomp (my $line=<FH>);
my $comp=$string cmp $line;
if ($comp!=0) {
print "Incorrect credentials.","\n";
admin_login();
}
else {
admin();
}
close FH;
}


sub admin {
print "\n";
print "\n","Options Available: ","\n","(1: View Questions, 2: Update Questions, 3: Add a question, 4: Delete a question, 5: Return to Home, 6: Exit)","\n","\n" ,"What do you want to do?: ";
my $entry=<STDIN>;
if ($entry==1) {view_ques();}
elsif ($entry==2) {update_ques();}
elsif ($entry==3) {add_ques();}
elsif ($entry==4) {delete_ques();}
elsif ($entry==5) {instr1();}
elsif ($entry==6) {exit;}
else {
print "Enter a valid request.","\n";
admin();
}
}

# VIEW QUESTIONS
sub view_ques {
my $ques_num=0;
open FH, "< questions.txt" or die $!;

while (my $line = <FH>) {
if ($line=~ /^$/) {
next;
}
else {
my @ques= (split ',', $line);
print "\n";
++$ques_num;

print "************************************************************************","\n";
print "QUESTION NUMBER $ques_num","\n";
print "************************************************************************","\n";
print "\n","Question: ",$ques[0],"\n";
print "A: ",$ques[1],"\n";
print "B: ",$ques[2],"\n";
print "C: ",$ques[3],"\n";
print "D: ",$ques[4],"\n";
print "Answer: ",$ques[5],"\n";
}
}
close FH;
admin();
}

# UPDATE QUESTION
sub update_ques {
#view_ques();
print "\n","Which question number do you want to update?: ";
chomp (my $update_ques=<STDIN>);
print "\n","Enter your question: ";
chomp (my $question=<STDIN>);
print "Option A: ";
chomp (my $optiona=<STDIN>);
print "Option B: ";
chomp (my $optionb=<STDIN>);
print "Option C: ";
chomp (my $optionc=<STDIN>);
print "Option D: ";
chomp (my $optiond=<STDIN>);
print "Answer: ";
chomp (my $answer=<STDIN>);
my $line_number=1;
open FH, "< questions.txt" or die $!;
open FW, "> temp_quiz.txt" or die $!;

while (my $line = <FH>) {
if ($line_number==$update_ques){
print FW "$question,$optiona,$optionb,$optionc,$optiond,$answer","\n";
}
else {
print FW $line;
}
$line_number++;
}
close FH;
close FW;
open FH, "< temp_quiz.txt" or die $!;
open FW, "> questions.txt" or die $!;
print FW <FH>;
close FH;
close FW;
print "\n","Question updated successfully.","\n";
admin();
}

# ADD QUESTION
sub add_ques {
print "\n","Enter your question: ";
chomp (my $question=<STDIN>);
print "Option A: ";
chomp (my $optiona=<STDIN>);
print "Option B: ";
chomp (my $optionb=<STDIN>);
print "Option C: ";
chomp (my $optionc=<STDIN>);
print "Option D: ";
chomp (my $optiond=<STDIN>);
print "Answer: ";
chomp (my $answer=<STDIN>);
open FH, ">> questions.txt" or die $!;
print FH "$question,$optiona,$optionb,$optionc,$optiond,$answer","\n";
close FH;
print "\n","Question added successfully.","\n";
admin();
}

# DELETE QUESTION
sub delete_ques {
print "In delete","\n";
print "\n","Which question number do you want to delete?: ";
chomp (my $update_ques=<STDIN>);
my $line_number=1;
open FH, "< questions.txt" or die $!;
open FW, "> temp_quiz.txt" or die $!;

while (my $line = <FH>) {
if ($line_number==$update_ques){
next;
}
else {
print FW $line;
}
$line_number++;
}
close FH;
close FW;
open FH, "< temp_quiz.txt" or die $!;
open FW, "> questions.txt" or die $!;
print FW <FH>;
close FH;
close FW;
print "\n","Question deleted successfully.","\n";
admin();

admin();
}

sub instr1 {
print "Login as? (1: User, 2: Administrator, 3: Exit)","\n" ,"Select one option: ";
my $entry=<STDIN>;
if ($entry==1) {user();}
elsif ($entry==2) {admin_login();}
elsif ($entry==3) {exit;}
else {
print "Enter a valid request.","\n";
instr1();
}
}


print "\n";
print "Welcome to the QUIZ PLATFORM!","\n","\n";
instr1();

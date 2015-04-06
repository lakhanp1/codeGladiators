use strict;
use warnings;

=head
A Company went to a college campus for hiring purpose. Various candidates participated in the
recruitment exam conducted by the employer. There are 10 final candidates left who qualified for the
vacancy. Employer maintains the marks of the candidate in the first test. Given a number K (1 ≤ K ≤
10), employer want to know that in how many ways he can select different set of K candidates out of 10
candidates such that their sum of marks in first test is maximum. Two set of K candidates would called
different if at least one of the candidate is not common in both set.
Input/Output Specifications
Input Specification:
1) An array of size 10 corresponding to the marks of 10 candidates.
2) Value K (1 ≤ K ≤ 10)
Output Specifications:
Number of different sets of K candidates corresponding to maximum summation
Examples
Example:
Input:
1) Candidate Marks
Candidate Marks
C1 2
C2 5
C3 1
C4 2
C5 4
C6 1
C7 6
C8 5
C9 2
C10 2
This is the marks of 10 candidates in the first test and employer has to select the team of 6 candidates
such that sum of their marks in first test is maximum.
2) 6 candidates
Output: 6 possible sets

=cut

my $combinations = CompanyRecruitment([2,2,2,2,2,2,2,2,2,2], 1);		#[2,5,1,2,4,1,6,5,2,2]

print "$combinations\n";

sub CompanyRecruitment { 
	my ($input1,$input2)= @_; 
	#Write code here 
	
	my $marksRef = shift @_;
	my $k = shift @_;
	
	my @marks = ();
	
	#handle input parameters
	if(ref $marksRef eq "ARRAY"){
		@marks = @{$marksRef};
	}
	elsif(ref $marksRef eq "REF"){
		my $tempDeref = ${$marksRef};
		@marks = @{$tempDeref};
	}
		
	#get the frequency of marks
	my %marksFreq = ();
	foreach(@marks){
		$marksFreq{$_}++;
	}
	
	my $addedFreq = 0;
	my $oldAddedFerq;
	my $toCombine = 0;
	
	my $N = 0;
	my $R = 0;
	foreach my $score(sort{$b <=> $a}keys %marksFreq){	
		
		$addedFreq += $marksFreq{$score};
		if($addedFreq >= $k){
			$toCombine = $marksFreq{$score} - ($addedFreq - $k);
			#print "$score : $marksFreq{$score}\t$addedFreq\tK = $k\tN = $marksFreq{$score}\tC = $toCombine\n";
			$N = $marksFreq{$score};
			$R = $toCombine;
			last;
		}
		
		$oldAddedFerq = $addedFreq;
	}
	
	my $sets = &ncr($N, $R);
	
	#return $sets;
}


sub ncr{
	my $n = shift @_;
	my $r = shift @_;
	
	my $fact = &factorial($n)/(&factorial($r) * &factorial($n-$r));
}


sub factorial{
	my $num = shift @_;
	
	if($num == 0){
		return 1;
	}
	
	if($num < 2){
		return $num;
	}
	else{
		return $num * factorial($num-1);
	}
	
}

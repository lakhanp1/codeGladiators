use strict;
use warnings;

=head
Stair cost problem: Jackson is playing an interesting game of climbing stairs. Every step of the stair has an associated jump value (call in Jfactor). So if he is at some step $i which has J-factor of Ji, then he can jump to any step from $i+1 to $i+Ji by just paying the cost of 1. If J-factor of a step is 0, player would stuck at that step.  So initially he is at step $1 and he has to reach final step $f. Question is that you are given J-factor for each step from $1 to $f and you have to reach from $1 to $f by paying minimal possible cost. You have to answer the minimal possible cost.

Input: If there are n steps then an array of n elements corresponding to the J-factor of n steps.
Output: Minimum possible cost to reach from step S1 to $fth step or return -1 if stuck

=cut

my $result = &StairCostProblem([1,3,5,8,9,2,6,7,6,8,9]);
###############################[0,1,2,3,4,5,6,7,8,9,10]
print $result;

sub StairCostProblem { 
	my ($input1)= @_; 
	#Write code here 
	my $dataRef = shift @_;
	
	my @jFactor = ();
	
	#dereferencing logic
	if(ref $dataRef eq "ARRAY"){
		@jFactor = @{$dataRef};
	}
	elsif(ref $dataRef eq "REF"){
		my $tempDeref = ${$dataRef};
		@jFactor = @{$tempDeref};
	}
	
	my $lastStep = $#jFactor;
	
	my $cost = 0;
	
	for(my $step=0; $step<=$lastStep; $step++){
		#print "Step: ",$step,": ",$jFactor[$step],"\n";
		
		
		if($step == 0 && $step == $lastStep){
			#if there is only one step, then cost will be 0 as first step is the last step
			$cost = 0;
			last;
		}
		elsif($step == 0 && $jFactor[$step] == 0){
			#if first step is 0 then stuck
			$cost = -1;
			last;
		}
		
		my $jumpMin = $step+1;
		my $jumpMax = $step + $jFactor[$step];
		
		#if jumpMax is more than the size of total steps: DONE. Reached the max step
		if($jumpMax >= $#jFactor){
			$jumpMax = $#jFactor;
			#take a jump i.e. increase the cost by 1
			$cost++;
			last;
		}
		
		my @jumpRange = @jFactor[$jumpMin..$jumpMax];
		
		#print "$jFactor[$step]: @jumpRange\n";
		my $nextStep = &takeBestJump(\@jFactor, \@jumpRange, $step, $lastStep);
		
		if($step == $nextStep){
			#if all of the step has jFactor = 0, then newStep will not be updated. It also means that algo is stuck
			$cost = -1;
			last;
		}
		else{
			#take a step: substracting -1 because by default the for loop will increment $step
			$cost++;
			$step = $nextStep - 1;
		}
	}
	
	
	return $cost;
}



sub takeBestJump{
	my $jFactorRef = shift @_;
	my $jumpsRef = shift @_;
	my $step = shift @_;
	my $finalStep = shift @_;
	
	my $bestStep = $step;
	
	my $tempRange = $step;
	
	my $indexCount = 0;
	foreach my $jump(@{$jumpsRef}){
		$indexCount++;
		
		#if the jFactor for current jump is 0 then its a block. So check next step
		if($jump == 0){
			next;
		}
	
		my $currentLongestJump = $step + $indexCount + $jump;
		#for any of the current steps, if jFactor is taking step beyond last step, we are done.
		if($currentLongestJump >= $finalStep){
			$bestStep = $step + $indexCount;
			last;
		}
		#update the bestStep if current step is giving more longer jump
		elsif($currentLongestJump > $tempRange){
			$tempRange = $currentLongestJump;
			$bestStep = $step + $indexCount;
		}
		
	}
	
	return $bestStep;
}

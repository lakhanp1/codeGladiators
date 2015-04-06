use strict;
use warnings;

=head
Some rats are moving on a rectangular surface which is made using rectangular bricks. Each brick has
its own temperature. Let us consider an example as shown in the figure 1. Number written on each brick
is temperature of that brick. Some rats (represented by small circles) are present on some positions
(i.e. bricks).

At any time, a rat will always move to that nearby brick, by moving to which he can undergo a minimum temperature change (in magnitude).
For example the rat shown by blue color will go to the left brick in 1st step (as change is minimum, if rat
will go to this nearby brick) as shown in figure 2. Possible movements of a rat are in only four directions
(upper, lower, left and right). You can see the movement of each rat in three steps after initial position is given for each rat in figure

Your program should output positions of all the rats after any number of steps say after n steps. You
can assume that temperature on each brick is an integer value. Also assume that, if you have choice in
movement (i.e. more than one positions give minimum change in magnitude) then preference should be
given in order upper, right, lower, left.

Input/Output Specifications
Input Specification:
Input should be Initial positions of rats, Temperature of bricks and Number of steps after which you
want to find the position of the rats. For the example considered in the question, input should be
['1#1','2#5','3#3','6#3'], ['2#6#8#6#-7','2#5#-5#-5#0','-1#3#-8#8#7','3#2#0#6#9','2#1#-4#5#8','-5#6#7#4#7'], 3
Here 1#1 is position of yellow rat, 2#5 is position of blue rat, 3#3 is position of red rat and 6#3 is position of
green rat.
Output Specification:
Output should be positions of rats after given number of steps . Note that output positions should be in
order of given input positions. For the example considered in the question, output is {2#1,2#4,2#3,6#2}


=cut

my @newPos = RatsPostions(['1#1','2#5','3#3','6#3'], ['2#6#8#6#-7','2#5#-5#-5#0','-1#3#-8#8#7','3#2#0#6#9','2#1#-4#5#8','-5#6#7#4#7'], 3);
#['1#1','2#5','3#3','6#3'], ['2#6#8#6#-7','2#5#-5#-5#0','-1#3#-8#8#7','3#2#0#6#9','2#1#-4#5#8','-5#6#7#4#7'], 3

print "@newPos";


sub RatsPostions{
	my ($input1, $input2, $input3) = @_;
	#write code here
	
	my $posRef = shift @_;
	my $matRef = shift @_;
	my $moves = shift @_;
	
	my @tempStart = ();
	my @tempMat = ();
	
	#handle the input type
	if(ref $posRef eq "ARRAY"){
		@tempStart = @{$posRef};
	}
	elsif(ref $posRef eq "REF"){
		my $tempDeref = ${$posRef};
		@tempStart = @{$tempDeref};
	}
	
	if(ref $matRef eq "ARRAY"){
		@tempMat = @{$matRef};
	}
	elsif(ref $matRef eq "REF"){
		my $tempDeref = ${$matRef};
		@tempMat = @{$tempDeref};
	}
	
	#preprocess the input data to get AoA
	my @startPos = ();
	my @matrix = ();
	
	foreach(@tempStart){
		push(@startPos, [split(/#/, $_)]);
	}
	
	foreach(@tempMat){
		push(@matrix, [split(/#/, $_)]);
	}
	
	#check if the input data is captured in correct format
	#foreach(@startPos){
	#	print "@{$_}\n";
	#}
	
	my @finalPos = @startPos;
	for(my $i=0; $i<$moves; $i++){
		#step i
		#print "Step $i:\n";
		for(my $rat=0; $rat<@finalPos; $rat++){
			#print "Rat $rat moves from [ @{$finalPos[$rat]} ] to: ";
			$finalPos[$rat] = &moveRat($finalPos[$rat], \@matrix);
			#print "@{$finalPos[$rat]}\n";
		}
		#print "\n";
	}
	
	foreach(@finalPos){
		$_ = join("#", @{$_});
	}
	
	return @finalPos;
}



sub moveRat{
	my $pos = shift @_;
	my $matRef = shift @_;
	
	#print "@{$pos}\t";
	$pos->[0]--;
	$pos->[1]--;
		
	my $bestMove;
	my $posDiff = undef;
	
	#check LEFT iff the column is not first
	if($pos->[1] != 0){
		$posDiff = abs($matRef->[$pos->[0]][$pos->[1]] - $matRef->[$pos->[0]][$pos->[1]-1]);
		$bestMove = [$pos->[0], $pos->[1]-1];
		#print "Updating to @{$bestMove}\t=>\t";
	}
	
	#check LOWER iff the row is not last
	if($pos->[0] != $#{$matRef}){
		my $tempDiff = abs($matRef->[$pos->[0]][$pos->[1]] - $matRef->[$pos->[0]+1][$pos->[1]]);
		if(!defined $posDiff){
			#LEFT brick was not explored so just set $posDiff and move ahead
			$posDiff = $tempDiff;
			$bestMove = [$pos->[0]+1, $pos->[1]];
			#print "Updating to @{$bestMove}\t=>\t";
		}
		elsif($tempDiff <= $posDiff){
			$bestMove = [$pos->[0]+1, $pos->[1]];
			$posDiff = $tempDiff;
			#print "Updating to @{$bestMove}\t=>\t";
		}
	}
	
	#check RIGHT iff the column is not last
	if($pos->[1] != $#{$matRef->[0]}){
		my $tempDiff = abs($matRef->[$pos->[0]][$pos->[1]] - $matRef->[$pos->[0]][$pos->[1]+1]);
		if(!defined $posDiff){
			#LEFT & LOWER bricks were not explored so just set $posDiff and move ahead
			$posDiff = $tempDiff;
			$bestMove = [$pos->[0], $pos->[1]+1];
			#print "Updating to @{$bestMove}\t=>\t";
		}
		elsif($tempDiff <= $posDiff){
			$bestMove = [$pos->[0], $pos->[1]+1];
			$posDiff = $tempDiff;
			#print "Updating to @{$bestMove}\t$tempDiff=>$posDiff\t";
		}
	}
	
	#check UP iff the row is not first
	if($pos->[0] != 0){
		my $tempDiff = abs($matRef->[$pos->[0]][$pos->[1]] - $matRef->[$pos->[0]-1][$pos->[1]]);
		if(!defined $posDiff){
			#LEFT & LOWER & RIGHT bricks were not explored so just set $posDiff and move ahead
			$posDiff = $tempDiff;
			$bestMove = [$pos->[0]-1, $pos->[1]];
			#print "***Updating to @{$bestMove}\t=>\t";
		}
		elsif($tempDiff <= $posDiff){
			$bestMove = [$pos->[0]-1, $pos->[1]];
			$posDiff = $tempDiff;
			#print "Updating to @{$bestMove}\t$tempDiff=>$posDiff\t";
		}
	}
	
	$bestMove->[0]++;
	$bestMove->[1]++;
	
	#print "@{$bestMove}";
	return $bestMove;
}

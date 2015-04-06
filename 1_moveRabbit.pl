use strict;
use warnings;

=head
In Today's Generation, there are very few number of rabbits left in the life. Our Environment
ministry is working very hard to protect them and to increase their life. They organised a general
awareness week for the general people for saving our rabbits. Various people attended the event
with their family and childrens. A very unique game is also organised for entertaining the
childrens. They are given a unique puzzle and various prizes are given to the childrens who solve
them brilliantly. There are n number of white rabbits sitting on left side of the pond and n
number of colored rabbits sitting on right side of the pond in the game. Their task is to move
each of the rabbits to the opposite side of the pond in minimum number of moves. For passing
the pond rabbits can use a lily pad. Rabbits can move by hopping or sliding onto a vacant lily
pad. A rabbit can only slide onto a vacant lily pad if it is next to it. A rabbit can only hop over
one another rabbit to land onto a vacant lily pad. Rabbits can't hop or slide backwards .

Input Specifications : n is the total number of rabbits on each side of the pond&nbsp;
Output Specifications : Total number of moves(as string) required to interchange the positions of the rabbits

Examples
example 1: Input: Total number of rabbits on each side of the pond is 1
Output: Total number of moves required to interchange the positions of the rabbits are 3(as string)
example 2: Input: Total number of rabbits on each side of the pond is 10000
Output: Total number of moves required to interchange the positions of the rabbits are 100020000(as string)
=cut

my $moves = &MovingRabbit(1000000000000000);
print $moves;

sub MovingRabbit { 
	use Math::BigInt;
	my ($input1)= @_; 
	my $rabits = shift @_;
	$rabits = Math::BigInt->new($rabits);
	
	my $moves = Math::BigInt->new(0);
	
	#its a series: (n**2) + (2 * n)
	#1	=>	3
	#2	=>	8
	#3	=>	15

	$moves = ($rabits**2) + (2 * $rabits);
	
	return $moves;
	
}




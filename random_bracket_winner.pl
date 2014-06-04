#!usr/bin/perl

###randomly pick a winning team

sub randomwinner {
	$e = int(rand(2));
	#print STDOUT "$e\t\n";
	return split(',',$_[$e]);
}


sub simulateround {
	###Round one

	@midwest = (randomwinner('MW1','MW16'),randomwinner('MW2','MW15'),randomwinner('MW3','MW14'),randomwinner('MW4','MW13'),randomwinner('MW5','MW12'),randomwinner('MW6','MW11'),randomwinner('MW7','MW10'),randomwinner('MW8','MW9'));
	@west = (randomwinner('W1','W16'),randomwinner('W2','W15'),randomwinner('W3','W14'),randomwinner('W4','W13'),randomwinner('W5','W12'),randomwinner('W6','W11'),randomwinner('W7','W10'),randomwinner('W8','W9'));
	@east = (randomwinner('E1','E16'),randomwinner('E2','E15'),randomwinner('E3','E14'),randomwinner('E4','E13'),randomwinner('E5','E12'),randomwinner('E6','E11'),randomwinner('E7','E10'),randomwinner('E8','E9'));
	@south = (randomwinner('S1','S16'),randomwinner('S2','S15'),randomwinner('S3','S14'),randomwinner('S4','S13'),randomwinner('S5','S12'),randomwinner('S6','S11'),randomwinner('S7','S10'),randomwinner('S8','S9'));

	###Round two
	@midwest2 = (randomwinner(@midwest[0],@midwest[7]),randomwinner(@midwest[1],@midwest[6]),randomwinner(@midwest[2],@midwest[5]),randomwinner(@midwest[3],@midwest[4]));
	@west2 = (randomwinner(@west[0],@west[7]),randomwinner(@west[1],@west[6]),randomwinner(@west[2],@west[5]),randomwinner(@west[3],@west[4]));
	@east2 = (randomwinner(@east[0],@east[7]),randomwinner(@east[1],@east[6]),randomwinner(@east[2],@east[5]),randomwinner(@east[3],@east[4]));
	@south2 = (randomwinner(@south[0],@south[7]),randomwinner(@south[1],@south[6]),randomwinner(@south[2],@south[5]),randomwinner(@south[3],@south[4]));

	###Round three
	@midwest3 = (randomwinner(@midwest2[0],@midwest2[3]),randomwinner(@midwest2[1],@midwest2[2]));
	@west3 = (randomwinner(@west2[0],@west2[3]),randomwinner(@west2[1],@west2[2]));
	@east3 = (randomwinner(@east2[0],@east2[3]),randomwinner(@east2[1],@east2[2]));
	@south3 = (randomwinner(@south2[0],@south2[3]),randomwinner(@south2[1],@south2[2]));

	###Division champ
	@midwestchamp = (randomwinner(@midwest3[0],@midwest3[1]));
	@westchamp = (randomwinner(@west3[0],@west3[1]));
	@eastchamp = (randomwinner(@east3[0],@east3[1]));
	@southchamp = (randomwinner(@south3[0],@south3[1]));

	#print STDOUT "MidWest Champ:@midwestchamp[0]\nWest Champ:@westchamp[0]\nEast Champ:@eastchamp[0]\nSouth Champ:@southchamp[0]\n\n";

	### Semi-finals
	@semis = (randomwinner(@midwestchamp[0],@westchamp[0]),randomwinner(@eastchamp[0],@southchamp[0]));
	@Finalswinner = randomwinner(@semis[0],@semis[1]);

	#print STDOUT "Champ:@Finalswinner[0]\n";
}

sub evaluateround {

	###Round one

	@midwestreal = ('MW1','MW2','MW3','MW4','MW12','MW6','MW7','MW8');
	@westreal = ('W1','W2','W14','W13','W12','W6','W10','W9');
	@eastreal = ('E1','E15','E3','E4','E5','E11','E7','E8');
	@southreal = ('S1','S2','S3','S4','S12','S6','S7','S9');

	for ($i=0;$i<8;$i++){
		if (@midwestreal[$i] eq @midwest[$i]){
			$score = $score + 1;
		}
		if (@westreal[$i] eq @west[$i]){
			$score = $score + 1;
		}
		if (@eastreal[$i] eq @east[$i]){
			$score = $score + 1;
		}
		if (@southreal[$i] eq @south[$i]){
			$score = $score + 1;
		}
	}

	###Round two
	
	@midwestreal2 = ('MW1','MW2','MW3','MW12');
	@westreal2 = ('W9','W2','W6','W13');
	@eastreal2 = ('E1','E2','E3','E4');
	@southreal2 = ('S1','S15','S3','S4');

	for ($i=0;$i<4;$i++){
		if (@midwestreal2[$i] eq @midwest2[$i]){
			$score = $score + 2;
		}
		if (@westreal2[i] eq @west2[$i]){
			$score = $score + 2;
		}
		if (@eastreal2[$i] eq @east2[$i]){
			$score = $score + 2;
		}
		if (@southreal2[$i] eq @south2[$i]){
			$score = $score + 2;
		}
	}

	###Round three
	
	@midwestreal3 = ('MW1','MW2');
	@westreal3 = ('W9','W2');
	@eastreal3 = ('E4','E3');
	@southreal3 = ('S4','S3');

	for ($i=0;$i<2;$i++){
		if (@midwestreal3[$i] eq @midwest3[$i]){
			$score = $score + 4;
		}
		if (@westreal3[$i] eq @west3[$i]){
			$score = $score + 4;
		}
		if (@eastreal3[$i] eq @east3[$i]){
			$score = $score + 4;
		}
		if (@southreal3[$i] eq @south3[$i]){
			$score = $score + 4;
		}
	}

	###Divisional champion round
	
	@midwestreal4 = ('MW1');
	@westreal4 = ('W9');
	@eastreal4 = ('E4');
	@southreal4 = ('S4');

	for ($i=0;$i<1;$i++){
		if (@midwestreal4[$i] eq @midwestchamp[$i]){
			$score = $score + 8;
		}
		if (@westreal4[$i] eq @westchamp[$i]){
			$score = $score + 8;
		}
		if (@eastreal4[$i] eq @eastchamp[$i]){
			$score = $score + 8;
		}
		if (@southreal4[$i] eq @southchamp[$i]){
			$score = $score + 8;
		}
	}
	
	###Semis round
	
	@winner1 = ('MW1');
	@winner2 = ('S9');
	
	if (@semis[0] eq @winner1[0]){
		$score = $score + 16;
	}
	if (@semis[0] eq @winner2[0]){
		$score = $score + 16;
	}
	
	###Championship

	@championreal = ('MW1');
	if (@Finalswinner[0] eq @championreal[0]){
		$correct = 1;
		$score = $score +32;
	}

	return $score;
}

print STDOUT "\n####How many brackets would you like to simulate?####\n";
$command = <STDIN>;
chomp $command;
print STDOUT "$command\n";
print STDOUT "What file should I print hand results to?\n";
$filename1 = <STDIN>;
open (OUTFILE1, ">>$filename1");
print OUTFILE1 "POINTS,Champ_correct\n";

for ($j = 0; $j < $command; $j++){
	simulateround();
	$value = evaluateround();
	print OUTFILE1 "$value,$correct\n";
	$score = 0;
	$correct = 0;
}

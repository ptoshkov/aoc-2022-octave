dat = importdata("day02.dat");

WIN_SCORE=6;
DRAW_SCORE=3;
LOSE_SCORE=0;
X_SCORE=1; % rock
Y_SCORE=2; % paper
Z_SCORE=3; % scissors

_map = containers.Map(
	{"A X", "A Y", "A Z", "B X", "B Y", "B Z", "C X", "C Y", "C Z"},
	[(X_SCORE + DRAW_SCORE),(Y_SCORE + WIN_SCORE),(Z_SCORE + LOSE_SCORE),(X_SCORE + LOSE_SCORE),(Y_SCORE + DRAW_SCORE),(Z_SCORE + WIN_SCORE),(X_SCORE + WIN_SCORE),(Y_SCORE + LOSE_SCORE),(Z_SCORE + DRAW_SCORE)]);

res1 = cellfun(@(x) _map(x), dat, 'UniformOutput', false);
res1 = sum([res1{:}]);

% assert(res1, 15337);

Z_SCORE=6; % win
Y_SCORE=3; % draw
X_SCORE=0; % lose
A_SCORE=1; % rock
B_SCORE=2; % paper
C_SCORE=3; % scissors

_map = containers.Map(
	{"A X", "A Y", "A Z", "B X", "B Y", "B Z", "C X", "C Y", "C Z"},
	[(C_SCORE + X_SCORE),(A_SCORE + Y_SCORE),(B_SCORE + Z_SCORE),(A_SCORE + X_SCORE),(B_SCORE + Y_SCORE),(C_SCORE + Z_SCORE),(B_SCORE + X_SCORE),(C_SCORE + Y_SCORE),(A_SCORE + Z_SCORE)]);

res2 = cellfun(@(x) _map(x), dat, 'UniformOutput', false);
res2 = sum([res2{:}]);














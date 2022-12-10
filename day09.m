dat = importdata ("day09.dat");

global Hpos;
Hpos = [0, 0];

global Tpos;
Tpos = [0, 0];

global histo;
histo = Tpos;

function [Hpos, Tpos] = moveht(Hpos, Tpos, direction)

	if strcmp(direction, "R")
		Hpos(1) += 1;
	elseif strcmp(direction, "L")
		Hpos(1) -= 1;
	elseif strcmp(direction, "U")
		Hpos(2) += 1;
	elseif strcmp(direction, "D")
		Hpos(2) -= 1;
	end

	distance = Hpos - Tpos;

	if ((distance(1) == 0) || (distance(2) == 0))
		Tpos += fix(distance/2);
	elseif ((abs(distance(1)) > 1) || (abs(distance(2)) > 1))
		Tpos += round(distance/2);
	end
end

function movehtwrapper(instruction)
	global histo;
	global Hpos;
	global Tpos;
	direction = strsplit(instruction," "){1};
	amount = str2num(strsplit(instruction," "){2});

	for i = 1:amount
		[Hpos, Tpos] = moveht(Hpos, Tpos, direction);
		histo(end+1, :) = Tpos;
	end

end

cellfun(@(x) movehtwrapper(x), dat, 'un', 0);
res1 = length(unique(histo, "rows"));

assert(res1, 6498);

global Poses;
Poses = zeros(10, 2);

histo = Poses(10, :);

function [Hpos, Tpos] = moveht(Hpos, Tpos)
	distance = Hpos - Tpos;

	if ((distance(1) == 0) || (distance(2) == 0))
		Tpos += fix(distance/2);
	elseif ((abs(distance(1)) > 1) || (abs(distance(2)) > 1))
		Tpos += round(distance/2);
	end
end

function movehtwrapper(instruction)
	global Poses;
	global histo;
	direction = strsplit(instruction," "){1};
	amount = str2num(strsplit(instruction," "){2});

	for i = 1:amount

		if strcmp(direction, "R")
			Poses(1, 1) += 1;
		elseif strcmp(direction, "L")
			Poses(1, 1) -= 1;
		elseif strcmp(direction, "U")
			Poses(1, 2) += 1;
		elseif strcmp(direction, "D")
			Poses(1, 2) -= 1;
		end

		for j = 1:9
			Hpos = Poses(j, :);
			Tpos = Poses(j + 1, :);
			[Hpos, Tpos] = moveht(Hpos, Tpos);
			Poses(j, :) = Hpos;
			Poses(j + 1, :) = Tpos;
		end

		histo(end+1, :) = Poses(10, :);
	end

end


cellfun(@(x) movehtwrapper(x), dat, 'un', 0);
res2 = length(unique(histo, "rows"));

assert(res2, 2531);









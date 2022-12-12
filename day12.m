global dat;
dat = importdata("day12.dat");
dat = cellfun(@double, dat, 'un', 0);
dat = cell2mat(dat);
START = find(dat=="S");
dat(START) = 97;
dat(dat == double("E")) = double("z") + 1;

global HEIGHT;
HEIGHT = size(dat)(1);

global WIDTH;
WIDTH = size(dat)(2);

global cost;
cost = dat + Inf;
cost(START) = 0;

function possible = lookaround(loc)
	global dat;
	global HEIGHT;
	global WIDTH;
	possible = [];

	% left
	tmp = loc - HEIGHT;

	if (tmp > 0)
		if (dat(tmp) - dat(loc)) <= 1
			possible(end+1) = tmp;
		end
	end

	% up
	tmp = loc - 1;

	if (rem(tmp,HEIGHT) > 0)
		if (dat(tmp) - dat(loc)) <= 1
			possible(end+1) = tmp;
		end
	end

	% right
	tmp = loc + HEIGHT;

	if (tmp <= length(dat(:)))
		if (dat(tmp) - dat(loc)) <= 1
			possible(end+1) = tmp;
		end
	end

	% down
	tmp = loc + 1;

	if (rem(loc,HEIGHT) ~= 0)
		if (dat(tmp) - dat(loc)) <= 1
			possible(end+1) = tmp;
		end
	end

end

loc = START;
visited = 0*dat;
tmp = length(dat(:));

while (~(all(visited(:))))
	visited(loc) = 1;
	possible = lookaround(loc);

	for new = possible
		cost(new) = min(cost(new), cost(loc) + 1);
	end

	temp = cost;
	temp(visited==1) = Inf;
	loc = find(temp==min(temp(:)))(1);
end

res1 = cost(dat==double("z") + 1)
assert(res1, 383);

clear all;

global dat;
dat = importdata("day12.dat");
dat = cellfun(@double, dat, 'un', 0);
dat = cell2mat(dat);
START = find(dat=="E");
dat(START) = double("z");
dat(dat == double("S")) = double("a");

global HEIGHT;
HEIGHT = size(dat)(1);

global WIDTH;
WIDTH = size(dat)(2);

global cost;
cost = dat + Inf;
cost(START) = 0;

function possible = lookaround(loc)
	global dat;
	global HEIGHT;
	global WIDTH;
	possible = [];

	% left
	tmp = loc - HEIGHT;

	if (tmp > 0)
		if (dat(tmp) - dat(loc)) >= -1
			possible(end+1) = tmp;
		end
	end

	% up
	tmp = loc - 1;

	if (rem(tmp,HEIGHT) > 0)
		if (dat(tmp) - dat(loc)) >= -1
			possible(end+1) = tmp;
		end
	end

	% right
	tmp = loc + HEIGHT;

	if (tmp <= length(dat(:)))
		if (dat(tmp) - dat(loc)) >= -1
			possible(end+1) = tmp;
		end
	end

	% down
	tmp = loc + 1;

	if (rem(loc,HEIGHT) ~= 0)
		if (dat(tmp) - dat(loc)) >= -1
			possible(end+1) = tmp;
		end
	end

end

loc = START;
visited = 0*dat;
tmp = length(dat(:));

while (~(all(visited(:))))
	visited(loc) = 1;
	possible = lookaround(loc);

	for new = possible
		cost(new) = min(cost(new), cost(loc) + 1);
	end

	temp = cost;
	temp(visited==1) = Inf;
	loc = find(temp==min(temp(:)))(1);

	if min(cost(dat==double("a"))) <= 383
		break
	end

end

res2 = min(cost(dat==double("a")))
assert(res2, 377);


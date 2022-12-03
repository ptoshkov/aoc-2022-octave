dat = importdata("day03.dat");

global OFFSET_LOWER;
OFFSET_LOWER = 96;
global OFFSET_UPPER;
OFFSET_UPPER = 38;

function [common] = find_common1(fullstr)
	global OFFSET_LOWER;
	global OFFSET_UPPER;
	mid = length(fullstr)/2;
	left = fullstr(1:mid);
	right = fullstr((mid + 1):end);
	common = intersect(left, right);

	if (isupper(common))
		common = double(common) - OFFSET_UPPER;
	else
		common = double(common) - OFFSET_LOWER;
	end
end

res1 = cellfun(@(x) find_common1(x), dat, 'UniformOutput', true);
res1 = sum(res1);

assert(res1, 7878);

rows = 3;
cols = ((size(dat))(1))/3;
dat = reshape(dat, rows, cols);
res2 = 0;

for (i = 1:cols)
	group = dat(:, i);
	tmp = intersect(group{1}, group{2});
	tmp = intersect(tmp, group{3});

	if (isupper(tmp))
		res2 += (double(tmp) - OFFSET_UPPER);
	else
		res2 += (double(tmp) - OFFSET_LOWER);
	end
end

assert(res2, 2760);
	















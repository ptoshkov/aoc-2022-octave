dat = importdata("day04.dat");

function [out] = is_subrange(range1, range2)
	out = (~(setdiff(range1, range2) && setdiff(range2, range1)));
end

function [range1, range2] = obtain_ranges(str)
	ranges = strsplit(str, ',');
	range1 = strsplit(ranges{1},'-');
	range2 = strsplit(ranges{2},'-');
	range1 = str2num(range1{1}):str2num(range1{2});
	range2 = str2num(range2{1}):str2num(range2{2});
end

function [out] = part1(str)
	[range1, range2] = obtain_ranges(str);
	out = is_subrange(range1, range2);
end

res1 = cellfun(@(x) part1(x), dat, 'un', false);
res1 = sum([res1{:}]);

assert(res1, 540);

function [out] = is_overlap(range1, range2)
	out = any(intersect(range1, range2));
end

function [out] = part2(str)
	[range1, range2] = obtain_ranges(str);
	out = is_overlap(range1, range2);
end

res2 = cellfun(@(x) part2(x), dat, 'un', false);
res2 = sum([res2{:}]);

assert(res2, 872);

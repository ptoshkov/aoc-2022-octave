dat = importdata("day06.dat"){1};

function [out] = find_unique_window(dat, len)
	out = 0;

	for i = 1:length(dat)
		seg = dat(i:i+len - 1);

		if (length(seg) == length(unique(seg)))
			out = i + len - 1;
			break;
		end
	end
end

res1 = find_unique_window(dat, 4);

assert(res1, 1582);

res2 = find_unique_window(dat, 14);

assert(res2, 3588);

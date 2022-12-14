dat = importdata("day13.dat","\n");

function out = compare(left, right)
	out = 0;
	len = min(length(left), length(right));
	left_tmp = left(1:len);
	right_tmp = right(1:len);
	idx1 = find(right_tmp<left_tmp);
	idx2 = find(left_tmp<right_tmp);
	if (isempty(idx1) && isempty(idx2))
		out = 0;
	elseif isempty(idx1)
		out = 1;
		return;
	elseif isempty(idx2)
		out = -1;
		return;
	else
		if (idx1(1)>idx2(1))
			out = 1;
			return;
		else
			out = -1;
			return;
		end
	end
	if ((out == 0) && (length(left) < length(right)))
		out = 1;
		return;
	end
	if ((out == 0) && (length(left) > length(right)))
		out = -1;
		return;
	end
end

assert(compare([1,1,3,1,1], [1,1,5,1,1]), 1);
assert(compare([1,1,6,1,1], [1,1,5,1,1]), -1);
assert(compare([2,3,4], 4), 1);
assert(compare(9, [8,7,6]), -1);
assert(compare([9], [8,7,6]), -1);
assert(compare([4,4], [4,4]), 0);
assert(compare([4,4], [4,4,4]), 1);
assert(compare([4,4,4], [4,4]), -1);

function dict = convert_to_dict(txt)
	txt = strrep(txt, "[", "{[");
	txt = strrep(txt, "]", "]}");
	dict = eval(txt);
end

res1 = [];

for i = 1:length(dat)
	dat{i} = convert_to_dict(dat{i});
end

function out = unpack(left, right)
	if (isempty(left) && (~(isempty(right))))
		out = 1;
		return;
	end

	if (isempty(right) && (~(isempty(left))))
		out = -1;
		return;
	end

	left_tmp = left;

	if (iscell(left_tmp))
		left_tmp = left{1};
	else
		left_tmp = left_tmp(1);
	end

	right_tmp = right;

	if (iscell(right_tmp))
		right_tmp = right{1};
	else
		right_tmp = right_tmp(1);
	end

	if (isempty(left_tmp) && (~(isempty(right_tmp))))
		out = 1;
		return;
	end

	if (isempty(right_tmp) && (~(isempty(left_tmp))))
		out = -1;
		return;
	end

	if (iscell(left_tmp) ||
		iscell(right_tmp))
		out = unpack(left_tmp, right_tmp);
	else
		out = compare(left_tmp, right_tmp);
	end

	if (out == 0)
		out = unpack(left(2:end), right(2:end));
	end

end

for i = 1:length(dat)

	if (~(rem(i, 2)))
		continue;
	end

	out = unpack(dat{i}, dat{i+1});

	if (out > 0)
		res1(end+1) = (i + 1)/2;
	end	

end

res1 = sum(res1);
% assert(res1, 6420)

dat(end+1) = convert_to_dict("[[2]]");
dat(end+1) = convert_to_dict("[[6]]");
before2 = 0;
before6 = 0;

for i = 1:(length(dat)-2)

	out = unpack(dat{i}, dat{end-1});

	if (out > 0)
		before2 += 1;
	end

	out = unpack(dat{i}, dat{end});

	if (out > 0)
		before6 += 1;
	end

end

res2 = (before2 + 1) * (before6 + 2);

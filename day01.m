fid = fopen("day01.dat");
dat = transpose((textscan(fid)){1});
fclose(fid);

res1 = 0;
_sum = 0;
res2 = zeros(1, 3);

for new = dat

	if isnan(new)
		res1 = max(res1, _sum);
		[val, idx] = min(res2);

		if (_sum > val)
			res2(idx) = _sum;
		end

		_sum = 0;
		continue;
	end

	_sum += new;


end

res1 = max(res1, _sum);
[val, idx] = min(res2);

if (_sum > val)
	res2(idx) = _sum
end

res2 = sum(res2);

assert(res1, 72718);
assert(res2, 213089);








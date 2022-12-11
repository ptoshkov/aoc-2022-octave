dat = importdata("day10.dat");
xreg = 1;
cycle = 0;
desired = [20, 60, 100, 140, 180, 220];
yreg = [];
res1 = 0;

global pixels;
pixels = "";

function draw_pixel(xreg, cycle)
	global pixels;
	cycle = rem(cycle, 40);
	overlap = ((xreg == cycle) || ((xreg + 1) == cycle) || ((xreg + 2) == cycle));

	if (overlap)
		pixels(end+1) = "#";
	else
		pixels(end+1) = ".";
	end

end

for i = 1:length(dat)
	instr = dat{i};

	if strcmp(instr, "noop")
		cycle += 1;
		yreg(end+1) = cycle*xreg;
		draw_pixel(xreg, cycle);

		if any(cycle == desired)
			res1 += (cycle*xreg);
		end

	else
		cycle += 1;
		yreg(end+1) = cycle*xreg;
		draw_pixel(xreg, cycle);

		if any(cycle == desired)
			res1 += (cycle*xreg);
		end

		cycle += 1;
		yreg(end+1) = cycle*xreg;
		draw_pixel(xreg, cycle);

		if any(cycle == desired)
			res1 += (cycle*xreg);
		end

		value = str2num(strsplit(instr, " "){2});
		xreg += value;
	end

end

res2 = reshape(pixels, 40, 6)';

assert(res1, 14560);
% assert(res2, "EKRHEPUZ");

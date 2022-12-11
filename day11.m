dat = importdata("day11.dat");
MONKEYS = length(dat)/6;

monkey.items = [];
monkey.operation = "";
monkey.test = NaN;
monkey.true_dst = NaN;
monkey.false_dst = NaN;

global monkeys;
monkeys = [monkey, monkey, monkey, monkey, ...
	monkey, monkey, monkey, monkey];

global inspections;
inspections = zeros(1,MONKEYS);

for i = 0:(MONKEYS-1)
	monkey = monkeys(i+1);
	startx = 2 + 6*i;
	items = strsplit(dat{startx}, ":"){2};
	items = str2num(items);
	monkey.items = items;
	operation = strsplit(dat{startx+1},"="){2};
	monkey.operation = operation;
	test = strsplit(dat{startx+2},"divisible by"){2};
	test = str2num(test);
	monkey.test = test;
	true_dst = strsplit(dat{startx+3}, "monkey"){2};
	monkey.true_dst = str2num(true_dst) + 1;
	false_dst = strsplit(dat{startx+4}, "monkey"){2};
	monkey.false_dst = str2num(false_dst) + 1;
	monkeys(i+1) = monkey;
end

function worry_lvl = inspect_item(item, operation)
	operation = strrep(operation, "old", num2str(item));
	operation = strrep(operation, "÷", "/");
	worry_lvl = eval(operation);
	worry_lvl = floor(worry_lvl/3);
end

function carry_out_actions(num)
	global monkeys;
	global inspections;
	len = length(monkeys(num).items);
	inspections(num) += len;

	for i = 1:len
		item = ((monkeys(num).items)(i));
		operation = monkeys(num).operation;
		worry_lvl = inspect_item(item, operation);
		test = monkeys(num).test;
		idx = 0;

		if rem(worry_lvl, test)
			idx = monkeys(num).false_dst;
		else
			idx = monkeys(num).true_dst;
		end

		(monkeys(idx).items)(end+1) = worry_lvl;
	end

	monkeys(num).items = [];
end

for i = 1:20
	for j = 1:MONKEYS
		carry_out_actions(j);
	end
end

res1 = sort(inspections)(end-1:end);
res1 = prod(res1)
assert(res1, 112815);

clear all;

dat = importdata("day11.dat");
MONKEYS = length(dat)/6;

monkey.items = [];
monkey.operation = "";
monkey.test = NaN;
monkey.true_dst = NaN;
monkey.false_dst = NaN;

global monkeys;
monkeys = [monkey, monkey, monkey, monkey, ...
	monkey, monkey, monkey, monkey];

global inspections;
inspections = zeros(1,MONKEYS);

for i = 0:(MONKEYS-1)
	monkey = monkeys(i+1);
	startx = 2 + 6*i;
	items = strsplit(dat{startx}, ":"){2};
	items = str2num(items);
	monkey.items = items;
	operation = strsplit(dat{startx+1},"="){2};
	monkey.operation = operation;
	test = strsplit(dat{startx+2},"divisible by"){2};
	test = str2num(test);
	monkey.test = test;
	true_dst = strsplit(dat{startx+3}, "monkey"){2};
	monkey.true_dst = str2num(true_dst) + 1;
	false_dst = strsplit(dat{startx+4}, "monkey"){2};
	monkey.false_dst = str2num(false_dst) + 1;
	monkeys(i+1) = monkey;
end

function worry_lvl = inspect_item(item, operation)
	operation = strrep(operation, "old", num2str(item));
	operation = strrep(operation, "÷", "/");
	worry_lvl = eval(operation);
	COMMON = 2*17*19*3*5*13*7*11;
	worry_lvl = rem(worry_lvl,COMMON);
end

function carry_out_actions(num)
	global monkeys;
	global inspections;
	len = length(monkeys(num).items);
	inspections(num) += len;

	for i = 1:len
		item = ((monkeys(num).items)(i));
		operation = monkeys(num).operation;
		worry_lvl = inspect_item(item, operation);
		test = monkeys(num).test;
		idx = 0;

		if rem(worry_lvl, test)
			idx = monkeys(num).false_dst;
		else
			idx = monkeys(num).true_dst;
		end

		(monkeys(idx).items)(end+1) = worry_lvl;
	end

	monkeys(num).items = [];
end

for i = 1:10000

	if (~(rem(i, 1000)))
		disp(i)
	end

	for j = 1:MONKEYS
		carry_out_actions(j);
	end
end

res2 = sort(inspections)(end-1:end);
res2 = prod(res2)
assert(res2, 25738411485);

dat = importdata("day05.dat", "\n");

HEIGHT = 8;
WIDTH = 9;

global stacks;
stacks = dat(1:HEIGHT);

global instructions;
instructions = dat(HEIGHT+2:end);

function [out] = get_stack(num)
	global stacks;
	from = 4*num - 3;
	to = from + 2;
	out = cellfun(@(x) x(from:to), stacks, 'un', false);
	out = cellfun(@strtrim, out, 'un', false);
	out = out(~(cellfun(@isempty, out)));
end

tmp = {};

for i = 1:WIDTH
	tmp{end+1} = get_stack(i);
end

stacks = tmp;
backup = stacks;

function [out] = parse_instruction(txt)
	out = regexp(txt, '\d*', 'Match');
	instruction.num = str2num(out{1});
	instruction.src = str2num(out{2});
	instruction.dst = str2num(out{3});
	out = instruction;
end

function process_instruction(instruction)
	global stacks;

	for i = 1:instruction.num
		new_dst = [stacks{instruction.src}{1}; stacks{instruction.dst}];
		new_src = stacks{instruction.src}(2:end);
		stacks{instruction.dst} = new_dst;
		stacks{instruction.src} = new_src;
	end
end

cellfun(@(x) process_instruction(parse_instruction(x)), instructions, 'un', false);
res1 = cellfun(@(x) x{1}(2:end-1), stacks, 'un', false);
res1 = [res1{:}];

assert(res1, "QNNTGTPFN");

function process_instruction(instruction)
	global stacks;
	to_move = {stacks{instruction.src}{1:instruction.num}}';
	new_dst = [to_move; stacks{instruction.dst}];
	new_src = stacks{instruction.src}(instruction.num+1:end);
	stacks{instruction.dst} = new_dst;
	stacks{instruction.src} = new_src;
end

stacks = backup;

cellfun(@(x) process_instruction(parse_instruction(x)), instructions, 'un', false);
res2 = cellfun(@(x) x{1}(2:end-1), stacks, 'un', false);
res2 = [res2{:}];

assert(res2, "GGNPJBTTR");







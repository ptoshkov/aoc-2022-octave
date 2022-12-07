fid = fopen("day07.dat");

row = fgetl(fid);

global stdout;
stdout = {};

dirs = unique({});

global files;
files = containers.Map('KeyType','char','ValueType','double');

global wd;
wd = "";

function update_wd(cmd)
	global wd;

	if strcmp(cmd, "$ cd /")
		wd = "/";
		return;
	end

	if strcmp(cmd(6:end), "..")
		slashix = strfind(wd, "/")(end-1);
		wd = wd(1:slashix);
	else
		wd = [wd, cmd(6:end), '/'];
	end
end

function process_stdout()
	global stdout;
	global files;
	global wd;

	for(i = 1:(size(stdout)(1)))
		filesz = strsplit(stdout{i}, " "){1};
		filenm = strsplit(stdout{i}, " "){2};

		if (isdigit(filesz(1)))
			fullnm = [wd, filenm];
			files(fullnm) = str2double(filesz);
		end

	end

	stdout = {};
end

while (ischar(row))

	if strcmp(row(1:4), "$ cd")
		process_stdout;
		update_wd(row);
		dirs = unique([dirs; wd]);
	elseif strcmp(row(1:4), "$ ls")
		process_stdout;
	else
		stdout = [stdout; {row}];
	end

	row = fgetl(fid);
end

process_stdout;

res1 = 0;
res2 = containers.Map('KeyType','char','ValueType','double');
du = 0;

for i = 1:length(dirs)
	directory = dirs{i};
	len = length(directory);
	children = [cellfun(@(x) strcmp(directory, x(1:min(end,len))), keys(files), 'un', 0){:}];
	childrensz = (values(files))(children);
	dirsz = sum([childrensz{:}]);

	if (dirsz < 100001)
		res1 += dirsz;
	end

	res2(directory) = dirsz;
	du = max(du, dirsz);
end

assert(res1, 1886043);

space_needed = 30000000 - (70000000 - du);
res2 = (values(res2))([cellfun(@(x) x >= space_needed, values(res2), 'un', 0){:}])
res2 = min([res2{:}])

assert(res2, 3842121);

fclose(fid);

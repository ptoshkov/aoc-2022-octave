global LEN;
LEN = length(importdata ("day08.dat"));

dat = fileread("day08.dat");
dat = double(dat) - 48;
dat = dat(dat >= 0);
dat = reshape(dat, LEN, LEN)';

ix_mat = reshape([1:LEN^2], LEN, LEN);
left_view = dat;
top_view = rot90(dat);
right_view = rot90(dat, 2);
bottom_view = rot90(dat, 3);

function out = visible_from_left(view)
	global LEN;
	out = [1:LEN]';

	for i = 2:LEN
		first = view(:, 1:i-1);
		second = view(:, i);
		visible = second > first;
		visible = (sum(visible, 2) == (i - 1))';
		start_ix = (i - 1)*LEN + 1;
		end_ix = start_ix + LEN - 1;
		ixs = [start_ix:end_ix];
		out = [out; nonzeros(ixs.*visible)];
	end
end

res1 = [visible_from_left(left_view);
rot90(ix_mat)(visible_from_left(top_view));
rot90(ix_mat, 2)(visible_from_left(right_view));
rot90(ix_mat, 3)(visible_from_left(bottom_view))];

res1 = length(unique(res1));

assert (res1, 1662);

function visible = visible_on_row(tree, row)
	global LEN;
	visible = 0;

	for i = 1:length(row)
		visible += 1;

		if (i < length(row))

			if ((row(i) >= tree) && (row(i + 1) <= row(i)))
				break;
			end

		end

	end

end

function out = score_from_left(view)
	global LEN;
	out = zeros(LEN, 1);

	for i = 2:LEN
		first = view(:, 1:i-1);
		second = view(:, i);
		trees_visible = [];

		for j = 1:LEN
			row = flip(first(j, :));
			tree = second(j);
			trees_visible(end+1) = visible_on_row(tree, row);
		end

		out = [out, trees_visible'];
	end
end

res2 = score_from_left(left_view);
res2 = res2.*rot90(score_from_left(top_view), -1);
res2 = res2.*rot90(score_from_left(right_view), -2);
res2 = res2.*rot90(score_from_left(bottom_view), -3);
res2 = max(max(res2));

assert(res2, 537600);














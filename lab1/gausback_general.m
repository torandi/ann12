%hidden_size = 100; % set this in console
%num_epoches = 20; % set in console
%n

% större layer size => bättre resultat, men längre tid till convergens

x=[-5:1:5]';
y=x;
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;

gridsize = size(x, 1);
ndata = gridsize*gridsize;

targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

% shuffle
permute = randperm(size(patterns,2));
[p1, inv_perm] = sort(permute);
patterns = patterns(:, permute);
targets = targets(:, permute);

sub_patterns = patterns(:, [1:1:n]);
sub_targets = targets(:, [1:1:n]);

% Fetch sizes
[insize, ndata] = size(sub_patterns);
[outsize, ndata] = size(sub_targets);



% Create initial weight matrix
W  = randn(hidden_size, insize+1) .* 2/sqrt(insize) - 1/sqrt(insize);
V  = randn(outsize, hidden_size+1) .* 2/sqrt(insize) - 1/sqrt(insize);

eta = 0.05; % step length
alpha = 0.90; % keep factor

dw = 0;
dv = 0;

X = [sub_patterns ; ones(1, ndata)];

for epoch=1:num_epoches

	% frist forward pass
	hin = W * X;
	hout = [ 2 ./ (1+exp(-hin)) - 1 ; ones(1, ndata)];

	oin = V * hout;
	out = 2 ./ (1+exp(-oin)) - 1;

	% backwards pass
	delta_o = (out - sub_targets) .* ((1 + out) .* (1 - out)) * 0.5;
	delta_h = (V' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
	delta_h = delta_h(1:hidden_size, :); 

	% Update weights
	dw = (dw .* alpha) - (delta_h * X') .* (1-alpha);
	dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
	W += dw .* eta;
	V += dv .* eta;

	% second forward pass
	hin = W * [patterns; ones(1, size(patterns, 2))];
	hout = [ 2 ./ (1+exp(-hin)) - 1 ; ones(1, size(patterns,2))];

	% render
	oin = V * hout;
	out = 2 ./ (1+exp(-oin)) - 1;
	ordered_out = out(:, inv_perm);
	zz = reshape(ordered_out, gridsize, gridsize);
	mesh(x,y,zz);
	axis([-5 5 -5 5 -0.7 0.7]);
	drawnow;

end


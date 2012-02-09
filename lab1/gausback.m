%hidden_size = 100; % set this in console
%num_epoches = 20; % set in console

x=[-5:1:5]';
y=x;
z=exp(-x.*x*0.1) * exp(-y.*y*0.1)' - 0.5;

gridsize = size(x, 1);
ndata = gridsize*gridsize;

targets = reshape (z, 1, ndata);
[xx, yy] = meshgrid (x, y);
patterns = [reshape(xx, 1, ndata); reshape(yy, 1, ndata)];

% Fetch sizes
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);



% Create initial weight matrix
W  = randn(hidden_size, insize+1) .* .001;
V  = randn(outsize, hidden_size+1) .* .001;

eta = 0.1; % step length
alpha = 0.9; % keep factor

dw = 0;
dv = 0;

X = [patterns ; ones(1, ndata)];

for epoch=1:num_epoches

	% forward pass
	hin = W * X;
	hout = [ 2 ./ (1+exp(-hin)) - 1 ; ones(1, ndata)];

	oin = V * hout;
	out = 2 ./ (1+exp(-oin)) - 1;

	% backwards pass
	delta_o = (out - targets) .* ((1 + out) .* (1 - out)) * 0.5;
	delta_h = (V' * delta_o) .* ((1 + hout) .* (1 - hout)) * 0.5;
	delta_h = delta_h(1:hidden_size, :); 

	% Update weights
	dw = (dw .* alpha) - (delta_h * X') .* (1-alpha);
	dv = (dv .* alpha) - (delta_o * hout') .* (1-alpha);
	%dw = -eta .* delta_h * X';
	%dv = -eta .* delta_o * hout';
	W += dw .* eta;
	V += dv .* eta;

	zz = reshape(out, gridsize, gridsize);
	mesh(x,y,zz);
	axis([-5 5 -5 5 -0.7 0.7]);
	drawnow;

end

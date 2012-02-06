% Fetch sizes
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);

% Create X, containing patterns and an extra row with ones
X = [patterns; ones(1, ndata)]; 


% Create initial weight matrix
W  = randn(outsize, insize+1) .* .001;

eta = 0.001; % step length

num_epoches = 20;


axis ([-2, 2, -2, 2], 'square');

for epoch=1:num_epoches
	% Calculate Y
	Y = W*X;
	% Calculate delta W
	dW = eta .* (Y - targets)*X';
	W -= dW;

	% plot data and separation line
	p = W(1, 1:2);
	k = -W(1, insize+1) / (p*p');
	l = sqrt(p*p');
	plot (patterns(1, find(targets>0)), ...
			patterns(2, find(targets>0)), '*', ...
			patterns(1, find(targets<0)), ...
			patterns(2, find(targets<0)), '+', ...
			[p(1), p(1)]*k + [-p(2), p(2)]/1, ...
			[p(2), p(2)]*k + [p(1), -p(1)]/1, '-');
	drawnow;
end

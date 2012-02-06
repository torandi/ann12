% Fetch sizes
[insize, ndata] = size(patterns);
[outsize, ndata] = size(targets);


% number of nodes in the hidden layer:
hidden_size = 10;

% Create initial weight matrix
W  = randn(hidden_size, insize+1) .* .001;
V  = randn(outsize, hidden_size+1) .* .001;

eta = 0.1; % step length
alpha = 0.9; % keep factor
num_epoches = 20;

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
	W += dw .* eta;
	V += dv .* eta;

	errors(epoch) = sum(sum(abs(sign(out) - targets) ./ 2));
end

plot(errors);

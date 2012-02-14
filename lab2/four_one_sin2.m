% Input:
% units = number of units

x = [0:0.1:2*pi]';
f = sin(2*x);

makerbf

phi = calcPhi(x, m, var);

w = phi\f;

y = phi*w;

rbfplot1(x, y, f, units); 
% subplot(2, 1, 1); plot(x, phi);

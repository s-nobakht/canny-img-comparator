function dG = dgauss(sig)
% Calculate Gaussian Filter according to input sigma (standard deviation)
x = floor(-3*sig):ceil(3*sig);
G = exp(-0.5*x.^2/sig^2);
G = G/sum(G);
dG = -x.*G/sig^2;

function [sFinal,thresh] = canny(img, mLow, mHigh, sig)
% Canny edge detector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function  [sFinal, thresh] =canny(img, mLow, mHigh, sig)
% this functions applys Canny edge detector algorithm on input image.
%  img  : input image in RGB or grayscale mode
%  mLow : adaptive lower threshold value: low_threshold = mLow* mean_intensity(im_gradient)
%  mHigh: adaptive higher threshold value: high_threshold= mHigh*low_threshold
%  sig  : standard deviation of gaussian
%
% The default values for (sig, mLow, mHigh) are set as (1, 0.5, 2.5).
% This function shows image and returns following values:
%  sFinal       : The final BW image including edges
%  thresh       :  =[lowT, highT] the real values of upper and lower thresholds
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Checking number of input arguments, raise error if needed,
% and initialize with default values.
if (nargin < 1)
  error(' Need a NxNx3 or NxN image matrix');
elseif (nargin ==1)
  mLow = 0.5; mHigh = 2.5; sig = 1;
elseif (nargin == 2)
  mHigh = 2.5; sig = 1;
elseif (nargin == 3)
  sig = 1;
end

% making a copy of input image
origImage = img;

% Checking image dimentions. If image is a RGB one, it should be converted
% to a grascale image.
if (ndims(img)==3)
  img =double(rgb2gray(img));
end


% CONVOLUTION WITH DERIVATIVE OF GAUSSIAN ast.

% Creatin a Gaussian filter
dG=dgauss(sig);

% get Gaussian filter size
[dummy, filterLen] = size(dG);

% set neede offset for filter
offset = (filterLen-1)/2;

% Doing convolution on Y direction
sy = conv2(img, dG ,'same');
% Doing convolution on X direction
sx = conv2(img, dG','same');

% get image size
[m, n]=size(img);

% remove marginal values
sx = sx(offset+1:m-offset, offset+1:n-offset); 
sy = sy(offset+1:m-offset, offset+1:n-offset); 

% calculate gradient norm
sNorm = sqrt( sx.^2 + sy.^2 );

% get direction of gradient
sAngle = atan2( sy, sx) * (180.0/pi);

% handling division by zero status
sx(sx==0) = 1e-10;
sSlope = abs(sy ./ sx);

% get a copy of gradient direction
sAorig = sAngle;

% here, x and x-pi are equal
y = sAngle < 0;
sAngle = sAngle + 180*y;

% angle containers
% 0-45 45-90 90-135 135-180

binDist =    [-inf 45 90 135 inf];

[dummy, b] = histc(sAngle,binDist);

sDiscreteAngles = b;
[m,n] = size(sDiscreteAngles);

% each pixel takes 1 to 4 values
% marginal pixels are set to zero and ignored
sDiscreteAngles(1,:) = 0;
sDiscreteAngles(end,:)=0;
sDiscreteAngles(:,1) = 0;
sDiscreteAngles(:,end) = 0;

% creating initial matrix for edge points
sEdgepoints = zeros(m,n);

sFinal = sEdgepoints;

% setting threshold values according percent of pixels intensity
lowT  = mLow * mean(sNorm(:));
highT = mHigh * lowT;

thresh = [ lowT highT];

% 'NON-MAXIMAL SUPPRESSION' section

% for each type of directions, we do an interpolation and check that current pointer
% is local maximum on that direction or not

% in continue, suppose that we are in (0,0), and should interpolate from 8 neighboring pixels.
% we are using single index here.

% gradient direction: 0-45 or gradDir =1
gradDir = 1;
indxs = find(sDiscreteAngles == gradDir);
slp = sSlope(indxs);

% interpolation between (1,1) and (1,0)
% gDiff1 = Gy/Gx*(magtd(0,0) - magtd(1,1)) + (1- Gy/Gx)*(magtd(0,0)-magtd(1,0))
gDiff1 = slp.*(sNorm(indxs)-sNorm(indxs+m+1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs+1));

% interpolation between (-1,-1) and (-1,0)
% gDiff2 = Gy/Gx*(magtd(0,0) - magtd(-1,-1)) +  (1- Gy/Gx)*(magtd(0,0)-magtd(-1,0))
gDiff2 = slp.*(sNorm(indxs)-sNorm(indxs-m-1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs-1));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


% gradient direction: 45-90 or gradDir =2
gradDir = 2;
indxs = find(sDiscreteAngles == gradDir);
invSlp = 1 ./ sSlope(indxs);

% interpolation between (1,1) and (0,1)
% gDiff1 = (Gx/Gy)*(magtd(0,0) - magtd(1,1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,1))
gDiff1 =   invSlp.*(sNorm(indxs)-sNorm(indxs+m+1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs+m));

% interpolation between (-1,-1) and (0,-1)
% gDiff2 = (Gx/Gy)*(magtd(0,0) - magtd(-1,-1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,-1))
gDiff2 =   invSlp.*(sNorm(indxs)-sNorm(indxs-m-1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs-m));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


% gradient direction: 90-135 ya gradDir =3
gradDir = 3;
indxs = find(sDiscreteAngles == gradDir);
invSlp = 1 ./ sSlope(indxs);

% interpolation between (-1,1) and (0,1)
% gDiff1 = (Gx/Gy)*(magtd(0,0) - magtd(-1,1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,1))
gDiff1 =   invSlp.*(sNorm(indxs)-sNorm(indxs+m-1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs+m));

% interpolation between (1,-1) and (0,-1)
% gDiff2 = (Gx/Gy)*(magtd(0,0) - magtd(1,-1)) + (1- Gx/Gy)*(magtd(0,0)-magtd(0,-1))
gDiff2 =   invSlp.*(sNorm(indxs)-sNorm(indxs-m+1)) + (1-invSlp).*(sNorm(indxs)-sNorm(indxs-m));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


% gradient direction: 135-180 ya gradDir =4
gradDir = 4;
indxs = find(sDiscreteAngles == gradDir);
slp = sSlope(indxs);

% interpolation between (-1,1) and (-1,0)
% gDiff1 = Gy/Gx*(magtd(0,0) - magtd(-1,1)) + (1- Gy/Gx)*(magtd(0,0)-magtd(-1,0))
gDiff1 = slp.*(sNorm(indxs)-sNorm(indxs+m-1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs-1));

% interpolation between (1,-1) and (1,0)
% gDiff2 = Gy/Gx*(magtd(0,0)-magtd(1,-1)) +  (1- Gy/Gx)*(magtd(0,0)-magtd(1,0))
gDiff2 = slp.*(sNorm(indxs)-sNorm(indxs-m+1)) + (1-slp).*(sNorm(indxs)-sNorm(indxs+1));

okIndxs = indxs( gDiff1 >=0 & gDiff2 >= 0);
sEdgepoints(okIndxs) = 1;


% HYSTERESIS section
% Finding powerful and weak edges according to threshold values
sEdgepoints = sEdgepoints*0.6;
x = find(sEdgepoints > 0 & sNorm < lowT);
% Zeroing edges that are less than weak edges
sEdgepoints(x)=0; 
x = find(sEdgepoints > 0 & sNorm  >= highT);
% Setting to 1 edges that are powerful
sEdgepoints(x)=1;

%sFinal(sEdgepoints>0)=1;

% in this part if:
%    sNorm(pixel) > lowT then sEdgepoints(pixel)=0
%    highT > sNorm(pixel) > lowT then sEdgepoints(pixel)=0.6
%    sNorm(pixel) > highT then sEdgepoints(pixel)=1


oldx = [];
% find points equals to 1
x = find(sEdgepoints==1);
while (size(oldx,1) ~= size(x,1))
  oldx = x;
  % neighbor points
  v = [x+m+1, x+m, x+m-1, x-1, x-m-1, x-m, x-m+1, x+1];
  % adding 0.4 to these points
  sEdgepoints(v) = 0.4 + sEdgepoints(v);
  % finding points that were 0 before, but now are equal to 0.4
  y = find(sEdgepoints==0.4);
  % zeroing these points
  sEdgepoints(y) = 0;
  % finding points that were 1 before, but now are greater than 1
  y = find(sEdgepoints>=1);
  % setting these points to 1
  sEdgepoints(y)=1;
  x = find(sEdgepoints==1);
end

% finding points that are finally 1, in other words, the final edge points
x = find(sEdgepoints==1);

% setting edge points to 1 on binary output
sFinal(x)=1;

% show image
%figure(1);
%imagesc(sFinal); colormap(gray); axis image;

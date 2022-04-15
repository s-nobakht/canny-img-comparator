function [ distanceMeasure ] = compareCannyEdges( edgeImage1, edgeImage2 )
%compareCannyEdges calculates similarity between two images according to Dausdorff Distance
%   this function takes two images containing edges of original images, then
%   calculates similarity of images according to Hausdorff Distance.
%   Two input images must have same size in number of columns. Thus, we should apply a checking
%   and rescaling step if needed.

% get sizes of input images
[rows1, cols1] = size(edgeImage1);
[rows2, cols2] = size(edgeImage2);
% check size and rescaling
if(cols1>=cols2)
    edgeImage1 = imresize(edgeImage1,cols2/cols1);    
elseif(cols1<cols2)
    edgeImage2 = imresize(edgeImage2,cols1/cols2);
end
% calculation of Hausdorff Distance
distanceMeasure = HausdorffDist(edgeImage1, edgeImage2, 0);

end

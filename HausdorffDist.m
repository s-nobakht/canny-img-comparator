function [hd D] = HausdorffDist(P,Q,lmf)
% calculate Hausdorff Distance between P and Q
%
% hd = HausdorffDist(P,Q)
% [hd D] = HausdorffDist(P,Q)
%
% This function calculates Hausdorff Distance between 2 point sets P and Q.
% The P and Q matrices must have same number of columns but, number of rows could be different.

%
% Directed Hausdorff Distance (dhd) defined as below:
% dhd(P,Q) = max p c P [ min q c Q [ ||p-q|| ] ].
% In fact, DHD finds the point p of the set P that is farthest from any point in Q,
% and finds the distance p to its neighbors in Q.
% 
% The Hausdorff Distance is defined by max{dhd(P,Q),dhd(Q,P)}.
%
% The matrix D is the distance matrix. So that D (n, m) is the distance of
% the nth point of the set P from the mth point of the set Q.
%

% get matrices sizes
sP = size(P); sQ = size(Q);

% Checking equality in number of columns
if ~(sP(2)==sQ(2))
    error('Inputs P and Q must have the same number of columns')
end

% check number of arguments
if nargin > 2 && ~isempty(lmf)
    % the user has specified the large matrix flag one way or the other
    largeMat = lmf;     
    if ~(largeMat==1 || largeMat==0)
        error('3rd ''lmf'' input must be 0 or 1')
    end
else
    largeMat = 0;   % assume this is a small matrix until we check
    % If the result is too large, we will not be able to build the matrix of
    % differences, we must loop.
    if sP(1)*sQ(1) > 2e6
        % ok, the resulting matrix or P-to-Q distances will be really big, lets
        % check if our memory can handle the space we'll need
        memSpecs = memory;          % load in memory specifications
        varSpecs = whos('P','Q');   % load in variable memory specs
        sf = 10;                    % build in a saftey factor of 10 so we don't run out of memory for sure
        if prod([varSpecs.bytes]./[sP(2) sQ(2)]) > memSpecs.MaxPossibleArrayBytes/sf
            largeMat = 1;   % we have now concluded this is a large matrix situation
        end
    end
end

if largeMat
% we cannot save all distances, so loop through every point saving only
% those that are the best value so far

maxP = 0;           % initialize our max value
% loop through all points in P looking for maxes
for p = 1:sP(1)
    % calculate the minimum distance from points in P to Q
    minP = min(sum( bsxfun(@minus,P(p,:),Q).^2, 2));
    if minP>maxP
        % we've discovered a new largest minimum for P
        maxP = minP;
    end
end
% repeat for points in Q
maxQ = 0;
for q = 1:sQ(1)
    minQ = min(sum( bsxfun(@minus,Q(q,:),P).^2, 2));
    if minQ>maxQ
        maxQ = minQ;
    end
end
hd = sqrt(max([maxP maxQ]));
D = [];
    
else
% we have enough memory to build the distance matrix, so use this code
    
% obtain all possible point comparisons
iP = repmat(1:sP(1),[1,sQ(1)])';
iQ = repmat(1:sQ(1),[sP(1),1]);
combos = [iP,iQ(:)];

% get distances for each point combination
cP=P(combos(:,1),:); cQ=Q(combos(:,2),:);
dists = sqrt(sum((cP - cQ).^2,2));

% Now create a matrix of distances where D(n,m) is the distance of the nth
% point in P from the mth point in Q. The maximum distance from any point
% in Q from P will be max(D,[],1) and the maximum distance from any point
% in P from Q will be max(D,[],2);
D = reshape(dists,sP(1),[]);

% Obtain the value of the point, p, in P with the largest minimum distance
% to any point in Q.
vp = max(min(D,[],2));
% Obtain the value of the point, q, in Q with the largets minimum distance
% to any point in P.
vq = max(min(D,[],1));

hd = max(vp,vq);

end






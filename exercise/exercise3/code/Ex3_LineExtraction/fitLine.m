%---------------------------------------------------------------------
% This function computes the parameters (r, alpha) of a line passing
% through input points that minimize the total-least-square error.
%
% Input:   XY - [2,N] : Input points
%
% Output:  alpha, r: paramters of the fitted line

function [alpha, r] = fitLine(XY)
% Compute the centroid of the point set (xmw, ymw) considering that
% the centroid of a finite set of points can be computed as
% the arithmetic mean of each coordinate of the points.

% XY(1,:) contains x position of the points
% XY(2,:) contains y position of the points

    x = XY(1,:)';
    y = XY(2,:)';

    xc = mean(x);
    yc = mean(y);

    % compute parameter alpha (see exercise pages)
    num   = - 2 * (x - xc)' * (y - yc);
    denom = sum((y - yc) .^ 2 - (x - xc) .^ 2);
    alpha = atan2(num, denom) / 2;

    % compute parameter r (see exercise pages)
    r = xc * cos(alpha) + yc * sin(alpha); 


% Eliminate negative radii
if r < 0,
    alpha = alpha + pi;
    if alpha > pi, alpha = alpha - 2 * pi; end
    r = -r;
end

end

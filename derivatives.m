%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% derivatives for the Lambert solver 
% source:https://www.researchgate.net/publication/260716341_Revisiting_Lambert's_Problem
%% Core

function [ d, d2, d3 ] = derivatives ( x, t, l2, l3, l5 )

% Pre-compute values
c1 = 1 - x * x;
c1_ = 1 / c1;
y = sqrt(1 - l2 * c1);
y2 = y * y;
y3 = y2 * y;
y5 = y3 * y2;

% Compute derivatives
if x==0
    d = -2; 
elseif x==1
    d = 0.4 * (l5 - 1);
else
    d = c1_ * (3*t*x - 2 + 2*l3*x/y); 
end

d2 = c1_ * (3*t + 5*x*d + 2*(1-l2)*l3/y3);
d3 = c1_ * (7*x*d2 + 8*d - 6*(1-l2)*l5*x/y5);

end

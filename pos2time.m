%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% computes the time of flight given the universal paramter and the lmbda
% variables
%
% Inputs:
%   x: 
%   lam: 
%   lam2: 
%
% Outputs:
%   t: time of flight
%% Core


function t = pos2time ( x,lam, lam2 )

% Semi-major axis
a = 1 / (1 - x*x);

% Compute TOF
if a > 0 % Ellipse
    alpha = 2 * acos(x);
    beta = 2 * asin(sqrt(lam2 / a));
    if lam < 0
        beta = -beta; 
    end
    
    t = (a*sqrt(a) * ((alpha - sin(alpha)) ...
        - (beta - sin(beta))))/2;
else % Hyperbola
    alpha = 2 * acosh(x);
    beta = 2 * asinh(sqrt(-lam2/a));
    
    if lam < 0
        beta = -beta; 
    end
    t = -a*sqrt(-a) * ((beta - sinh(beta)) - (alpha - sinh(alpha)))/2;
end

end


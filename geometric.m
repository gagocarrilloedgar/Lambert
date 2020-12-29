%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Computes the hypergeometric series of a given number
% source:https://www.researchgate.net/publication/260716341_Revisiting_Lambert's_Problem
%% CORE

function f = geometric (x)

% Initialization
f = 1;
frac = 1;

% Compute series
for k = 0:1e3
    
    frac = frac * (3+k) * (1+k) / (2.5+k) * x / (k+1);
    f = f + frac;
    
    if abs(frac) <= 1e-9
        break;
    end
end

end
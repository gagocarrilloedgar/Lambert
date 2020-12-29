%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Solves E = M + e*sin(M) using the Newton-Rapson iterative method
% Inputs:
%   e  = orbit's eccentricity
%   delta = maximum admisible error
%   M = Mean anomaly d
%
% Ouput:
% 
%   i: Last iteration
%   E : Ecc anomaly,
%
%% Core

function [ E, i ] = keplerslv ( M, e, delta )

% Fix M within allowed range
M = mod(M,2*pi);

% Initial guess for E
E = M;

for i=1:1e3
    
    % Backup current value
    E_ = E;
    
    % Compute new value
    E = E - (E - e * sin(E) - M);
    dt =  (1 - e * cos(E));
    E = E/dt;
    
    % Tolerance achieved
    if abs(E - E_) < delta
        break;
    end
    
end

end

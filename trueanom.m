%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
%   Computes the true anomaly theta corresponding to an eccentric anomaly E
%
% Inputs:
%   E: eccentric anomaly 
%   e: eccentricity 
%
% Outputs:
%   theta: true anomaly
%
%% CODE
function theta = trueanom ( E, e )

if e < 1 
    theta = 2.0 * atan(sqrt((1.0 + e) ./ (1.0 - e)) .* tan(E / 2.0));
elseif e > 1 
    theta = 2.0 * atan(sqrt((e + 1.0) ./ (e - 1.0)) .* tanh(E / 2.0));
else 
    theta = 2.0 * atan(E);
end

end

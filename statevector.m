%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
%   Converts a set of orbital elements to state vector 
% Inputs:
%   a: semi-major axis 
%   e: eccentricity
%   i: inclination 
%   theta: true anomaly 
%   w: argument of periapsis 
%   raan: right ascension of ascending node 
%   mu: standard gravitational parameter of the sun
%
% Outputs:
%   r_: position 
%   v_: velocity 
%
%
%% Core

function [ r_, v_ ] = statevector ( a, e, i, theta, argp, w, mu )

if e~=1
    p = a * (1 - e^2); % Ellipse, Hyperbola
else
    p = a; % Parabola (arbitrary convention)
end

% Calculate position and vel (norm)
r = p / (1 + e * cos(theta));

v = sqrt(mu / p);

% Position  vect
r_v = r * [cos(theta); sin(theta); 0];

% Velocity vector
v_v = v * [-sin(theta); e + cos(theta); 0];

%Rotation ma
R313 = rotz(w)*rotx(argp)*rotz(i);

% Rotate vectors to ICF (xyz) 
r_ = (R313 * r_v)';
v_ = (R313 * v_v)';

end

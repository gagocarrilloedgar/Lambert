%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
% Subject: Astrodynamics
%
% date2pos
%
% Description
%   Returns the position and velocity of a celestial body at a given
%   Calendar/J2000 date
%
% Inputs:
%   body: body full name
%   JD: days from J2000
%   mu: standard gravitational parameter (sun)
%   planar: decides whether the positions will be planar or not ( i=0 or
%   i!=0
%
% Outputs:
%   r: position
%   v: velocity 
%
%% CODE

function [ r, v ] = date2pos ( planet, JD, mu, planar )

% Get orbital elements
[ a, e, i, M, argp, w ] = obtelements ( planet, JD );

% Compute eccentric anomaly E
E = keplerslv(M,e,1e-6);

% Compute true anomaly nu
theta = trueanom(E,e);

% Force planar scenario
if planar
    i = 0;
    %e = 0;
end

% Convert orbital elements to ICF state vector
[ r, v ] = statevector ( a, e, i, theta, argp, w , mu );

end

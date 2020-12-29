%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% main core of the program from where all function will be called
%
%% Core
% Planets selection 
departure_planet = 'Earth';
arrival_planet = 'Saturn';

%Standard gravitational parameter of the sun
mu = 1.32712440018E11; % [km^3 s^-2]

% Solver parameters
delta = 1e-6; % tolerance error

% Julian century reference
julian_ref = date2julian ( 2000, 1, 1, 12, 0, 0);

% Planar definition
planar_ = [0]; %[0,1];
Z = length(planar_);
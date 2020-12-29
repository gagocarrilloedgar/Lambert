%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% vector initialization for the main program
%
%% CORE
% Time window
depi = date2julian ( 2023, 1, 1, 0, 0, 0) - julian_ref;
depf = date2julian ( 2024, 1, 1, 0, 0, 0) - julian_ref;
departures = depi:5:depf;

% Time of flight
time = 400:5:5000;

% Matrix size
N = length(departures);
M = length(time);

% Space allocation
v1 = zeros(N,M);
v2 = v1;
tof_mtrx = v1;
c3 = v1;
DV = v1;
DV_max = v1;
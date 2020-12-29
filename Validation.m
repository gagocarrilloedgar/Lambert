%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% main code where the validation process will be made
%
%% CODE

clc; clear; close all;
set(groot,'defaulttextInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');

%% Inputs
Inputs

%% Core
dep_date = date2julian( 2020, 1, 2, 0, 0, 0) - julian_ref;

Dt = 12.358; % value for the validation case create vector 
% to generate the validations plots
M = length(Dt);
z = zeros(M,3);
rd = [1,0,0];
ra = [0,-1,0];
mvnt = 1;

% Time of flight
for j=1:M
    for i=1:1
        dtheta = deltatheta( rd, ra, mvnt); % Transfer angle
        [v1,v2,z(j,i)] = lambertbis( rd, ra, Dt(j),mu,dtheta);
    end
end

%% Postprocess

plots="validation";
postprocess

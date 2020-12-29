%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Subject: Astrodynamics
%
%   Compute the Julian Date JD
%
% Inputs:
%   Calendar matlab date format: year, month, day, hour, minute, second
%
% Outputs:
%   JD: Julian Day
%
%% Core

function [ JD ] = date2julian ( year, month, day, hour, minute, second)

a = floor((14-month)/12);
y = year + 4800 - a;
m = month + 12*a - 3;

% Compute Julian Day Number
JDN = day + floor((153*m + 2)/5) + 365*y + floor(y/4) - 32083;

% Find Julian Date
JD = JDN + (hour - 12)/24 + minute/1440 + second/86400;

end

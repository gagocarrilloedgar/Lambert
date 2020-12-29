%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
%   Computes the angle between two 3D vectors.
%
% Inputs:
%   r1: first vector 
%   r2: second vector 
%   mvnt: prograde motion (1), retrograde motion (0)
%
%% Core

function theta  = deltatheta ( r1, r2, mvnt )


A = acos(dot(r1,r2) / (norm(r1) * norm(r2)));

B = cross(r1,r2);
Bz = B(3); %Z-component

% Check motion case
if mvnt
    if Bz >= 0
        theta = A;
    else
        theta = 2*pi - A;
    end
else
    if Bz < 0
        theta = A;
    else
        theta = 2*pi - A;
    end
end

end

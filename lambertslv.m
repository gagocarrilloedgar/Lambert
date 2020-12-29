%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Lambert problem using a third order solver
%
% Inputs:
%   r1: position vector of departure point
%   r2: position vector of arrival point
%   tof: time of flight
%   mu: standard gravitational parameter of the sun
%   lw: transfer type (short/long)
%   delta: iteration tolerance:
%
% Outputs:
%   v1: departure velocity
%   v2: arrival velocity
% source:https://www.researchgate.net/publication/260716341_Revisiting_Lambert's_Problem

%% Core

function [ v1, v2 ] = lambertslv ( r1, r2, tof, mu, lw, delta,theta)

% Preprocess
c1 = norm(r1);
c2 = c1 / sqrt(mu / c1);
c3 = c1^3 / c2^2;

r1 = r1 / c1;
r2 = r2 / c1;
tof = tof / c2;
mu = mu / c3;

v1 = NaN*[0,0,0];
v2 = NaN*[0,0,0];

r1_ = norm(r1);
r2_ = norm(r2);
lws = -(2 * lw - 1);

% Compute geometrical parameters
h = cross(r1,r2); 
c = norm(r2 - r1); 
s = 0.5 * (r1_ + r2_ + c); 
lam2 = 1 - c/s; 
lam = lws * sqrt(lam2); 
lam3 = lam2 * lam; 
lam5 = lam3 * lam2; 
t = sqrt(2 * mu / (s*s*s)) * tof;

if mod(theta,pi)==0
    h = [0,0,1];
end

%% Initial guess

% Parameters
max_ = floor(t/pi);
t0_ = acos(lam) + lam * sqrt(1 - lam2); 
t0_m = t0_ + max_ * pi; 
t1 = 2/3 * (1 - lam3); 

if t >= t0_m
    x0 = -(t - t0_) / (t - t0_ + 4); 
elseif t <= t1
    x0 = 2.5 * (t1 * (t1 - t)) / (t * (1 - lam5)) + 1; 
else
    x0 = (t / t0_)^(log(2) / log(t1 / t0_)) - 1; 
end

% Initialization of the loop
x = x0;
frac=1;

while (abs(frac)>delta)
    
    % TOF
    TOF = pos2time ( x, lam, lam2 );
    
    % Derivatives
    [ dt, d2t, d3t ] = derivatives ( x, TOF, lam2, lam3, lam5 );
    
    % Next step
    d = TOF - t;
    d2 = d * d;
    dt2 = dt * dt;
    frac = d * (dt2-d*d2t/2) / (dt*(dt2-d*d2t) + d3t*d2/6);
    x = x - frac; 
end

% Compute velocity vectors
r1_u = r1/r1_;
r2_u = r2/r2_;

gamma = sqrt(mu * s / 2);
rho = (r1_ - r2_) / c;
sigma = sqrt(1 - rho^2);

y = sqrt(1 - lam2 * (1 - x^2));
vr_1n = + gamma*(lam*y - x - rho*(lam*y + x)) / r1_; 
vr_2n = - gamma*(lam*y - x + rho*(lam*y + x)) / r2_; 

vt = gamma * sigma * (y + lam * x);
vt_1n = vt / r1_; 
vt_2n = vt / r2_;

h_r1 = lws * cross(h,r1);
h_r1u = h_r1/norm(h_r1);
h_r2 = lws * cross(h,r2);
h_r2u = h_r2/norm(h_r2);

v1_ = vr_1n * r1_u + vt_1n * h_r1u;
v2_ = vr_2n * r2_u + vt_2n * h_r2u;

v1 = v1_ * c1 / c2;
v2 = v2_ * c1 / c2;

v1 = v1(:)';
v2 = v2(:)';

end







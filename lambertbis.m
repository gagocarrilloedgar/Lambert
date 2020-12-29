%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Lambert solver using the simó method, computes the Dt problem using the bisecction method
%
% Inputs:
%   r1: position vector of departure point
%   r2: position vector of arrival point
%   tof: time of flight
%   mu: standard gravitational parameter (sun)
%
% Outputs:
%   v1: final velocity at departure 
%   v2: initial velocity at arrival 
%
%% Core

function [v1,v2,z] = lambertbis(r1,r2,TOF,mu,theta)

r1_ = norm(r1);
r2_ = norm(r2);


[Q,P,A,C]= geometry(theta,r1_,r2_);

i = 1;
z_low = -(pi/2)^2;
z_high = (pi)^2;
f_low= transfertime(z_low,Q,P,mu);

while ~isreal(f_low)
    i = i +1;
    z_low_(i) = z_low + 0.1;
    z_low = z_low_(i);
    f_low_(i) = transfertime(z_low,Q,P,mu);
    f_low = f_low_(i);
end


f_high = transfertime(z_high,Q,P,mu);


% Init
err = 1;
i = 1;

while abs(err)>1e-3
    
    z = 0.5*(z_low+z_high);
    f = transfertime(z,Q,P,mu);
    err = TOF-f;
    i = i+1;
    
    if(f<TOF)
        z_low = z;
    else
        z_high = z;
    end
    
    if(i>1e3)
        disp("not converged");
        break;
    end
    %f_val = f;
end

%terminal velocites
p = (2*A*A*C*C)/(P- Q*c0(z));
f = 1 - (r1_/p)*cos(theta);
g_dot = f;
g = ((r1_*r2_)/sqrt(mu*p))*sin(theta);

v1 = (r2-f*r1)/g;
v2 = (g_dot*r2 - r1)/g;

% % Unncomment for validation mode
% p = (2*A*A*C*C)/(P- Q*c0(7));
% a = ((P- Q*c0(7))/(2*7*c1(7)^2));
% e = sqrt(1 - (A*A*C*C)/(a*a*7*c1(7)^2));
% 
% fprintf("---Validation case for z=7 ---\n");
% fprintf("DT = %0.3f \n",f_val);
% fprintf("iteration = %f \n",i);
% fprintf("p = %0.3f \n",p);
% fprintf("a = %0.3f \n",a);
% fprintf("e = %0.3f \n",e);
% fprintf("-----------------------------\n");
end


function dt = transfertime(z,Q,P,mu)

a = 2 * P*c3(4*z);
b = Q *(c1(z)*c2(4*z)-2*c0(z)*c3(4*z));
c = c1(z)^3;
d = sqrt(2*((P-Q*c0(z))/mu));

dt =((a+b)/c)*d;

end

function [Q,P,A,C]= geometry(theta,r1,r2)

Q = 2*sqrt(r1*r2)*cos(theta/2);
P = r1 + r2;

A = sqrt(r1);
C = sqrt(r2)*sin(theta/2);
end


function x = c2(z)
if (z == 0)
    x=1;
else
    x=(1-c0(z))/z;
end

end

function x = c3(z)
if(z ~=0)
    x=(1-c1(z))/z;
else
    x=1;
end
end

function x = c0(z)

if(z>0)
    x = cos(sqrt(z));
elseif z == 0
    x = 1;
else
    x = cosh(sqrt(-z));
end

end

function x = c1(z)

if(z>0)
    x = sin(sqrt(z))/sqrt(z);
elseif z == 0
    x = 1;
else
    x = sinh(sqrt(-z))/sqrt(-z);
end

end




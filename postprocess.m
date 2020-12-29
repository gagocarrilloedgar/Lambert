%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
%   Generation of the main problem plots (both PCS and Validation)
%
%% Core

% PCS

if (plots=="PCP")
    
    for i=1:N
        axis_cal(i) = datetime(departures(i)+julian_ref,'ConvertFrom','juliandate','Format','dd-MMM-yyyy');
    end
    
    figure(1)
    contourf(time,datenum(axis_cal),DV,'edgecolor','none');
    datetick('y','dd-mm-yy','keeplimits','keepticks');
    xlabel('Time of Flight [days]');
    %ylabel('Departure from Earth (Day-Month-Year)');
    %ylabel('Departure from Earth (Day-Month-Year)');
    ylabel('Departure from Mercury (Day-Month-Year)');
    %title('Total DV, Planar [km/s]');
    %title('Total DV, 3D Mercury - Earth [km/s]');
    title('Total DV, 3D Mercury - Earth [km/s]');
    colorbar;

    figure(2)
    contourf(time,datenum(axis_cal),DV_max,'edgecolor','none');
    datetick('y','dd-mm-yy','keeplimits','keepticks');
    xlabel('Time of Flight [days]');
    ylabel('Departure from Earth (Day-Month-Year)');
    %title('Total DV max=50[km/s]');
    %title('Total DV, 3D Mercury - Earth, max=50[km/s]');
    title('Total DV, 3D Earth - Saturn, max=50[km/s]');
    colorbar;
    
else
    % Validation
    figure;
    plot(z(:,1),Dt);
    hold on
    plot(z(:,2),Dt);
    plot(z(:,3),Dt);
    title('Validation test for $\Delta t$')
    ylabel('$\Delta t [NU]$');
    xlabel('$z = \rho s_2^2$');
    string = sprintf('Delta \theta = %0.2d',rad2deg(dtheta));
    legend('$\Delta \theta = 180^{\circ}$','$\Delta \theta = 90^{\circ}$','$\Delta \theta = 270^{\circ}$','location','best')
    
    theta1_ = linspace(0,pi,50);
    theta2_ = linspace(0,pi/2,50);
    theta3_ = linspace(0,3*pi/2,50);
    
    
    x1 = cos(theta1_);
    y1  = sin(theta1_);
    
    x2 = cos(theta2_);
    y2  = sin(theta2_);
    
    x3 = cos(theta3_);
    y3  = sin(theta3_);
    
    figure;
    plot(x2,y2);
    hold on;
    ylabel("y [NU]");
    xlabel("x [NU]");
    xlim([-0.1 1.1]);
    ylim([0 1.1]);
    title('$\Delta \theta = 90^{\circ}$');
    plot(linspace(0,1,50),zeros(1,50),'r');
    plot(zeros(1,50),linspace(0,1,50),'g');
    legend("Transfer","$r_1$","$r_2$",'Location',"best");
    
    
    figure;
    plot(x1,y1);
    hold on;
    ylabel("y [NU]");
    xlabel("x [NU]");
    xlim([-1.1 1.1]);
    ylim([0 1.1]);
    title('$\Delta \theta = 180^{\circ}$');
    plot(linspace(0,1,50),zeros(1,50),'r');
    plot(linspace(0,-1,50),zeros(1,50),'g');
    legend("Transfer","$r_1$","$r_2$",'Location',"best");
    
    figure;
    plot(x3,y3);
    hold on;
    ylabel("y [NU]");
    xlabel("x [NU]");
    xlim([-1.1 1.1]);
    ylim([-1.1 1.1]);
    title('$\Delta \theta = 270^{\circ}$');
    plot(linspace(0,1,50),zeros(1,50),'r');
    plot(zeros(1,50),linspace(0,-1,50),'g');
    legend("Transfer","$r_1$","$r_2$",'Location',"best");
end


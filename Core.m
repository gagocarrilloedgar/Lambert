%% Astrodynamics | Lambert Solver
% Authors: Casanovas, Marc
%          Gago, Edgar
%          Ibañez, Carlos
% Date 20/12/2020
%
% Description
% Core of the main program 
%
%% Core

for k = 1:Z
    for j=1:M
        for i=1:N
            
            %Select if planar
            planar = planar_(k);
            
            %Compute dates
            departure = departures(i);
            JD2 = departure + time(j);
            
            travel = [departure, JD2];
            TOF = travel(2:length(travel)) - travel(1:length(travel)-1);
            
            % Position
            [ rd, vd ] = date2pos ( departure_planet, travel(1), mu,planar);
            [ ra, va ] = date2pos ( arrival_planet, travel(2), mu,planar);
            
            % TOF pass time to seconds
            TOF = TOF * (24*60*60);
            
            % Compute and check theta direction
            theta = deltatheta ( rd, ra, 1 ); % Transfer angle
            if theta > pi
                lw = 1;
            else
                lw = 0;
            end % Long/short way tranfer
            
            %Lambert Solver
            [ v1_, v2_ ] = lambertslv(rd,ra,TOF,mu,theta);

            
            % Save values for postprocess
            v1(i,j) = norm(v1_-vd);
            v2(i,j) = norm(v2_ - va);
            c3(i,j) = v1(i,j)^2;
            DV(i,j) = v2(i,j) +  v1(i,j);
            
            % Check maximum delta V
            DV_max(i,j)=DV(i,j);
            if(DV_max(i,j)>50)
                DV_max(i,j)=50;
            end
            
        end
    end
end

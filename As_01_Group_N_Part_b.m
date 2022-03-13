%% Assignment 01 GROUP - N
   % 21CH60R52 Alok Ranjan
   % 21CH60R53 Rajat Gupta
   % 21CH60R54 Mayalekshmi S
%% MATLAB code for the solution of Initial Value ODEs Part (b)
%% parameters 
clc
k   = 0.01:0.01:1;         % rate constant
tau = linspace(0,100,100);   % space time
%% initial condition
Cao = 20;% mol/Lit
%% Defining ODEs function
tspan = [1:1:100]; % time span in minutes
y0 = [20,0,0,0]; % initial conditions of each species

for  i = 1:length(tau)
    for j = 1:length(k)
        [t,y] = ode45(@(t,y) odefcn(t,y,tau(i),k(j),Cao), tspan,y0);
        a = y(:,1);
        b = y(:,2);
        c = y(:,3);
        d = y(:,4);
        L = length(a);
        
        for m = 1: L-1
            if a(m)-a(m+1) < 0.01   % check for steady state
                CA1(j) = a(m);      % if condition satisfy assign the value
                m = L-1;            % move to next value
            end
        end
        for m = 1: L-1
            if b(m+1)-b(m) < 0.01   % check for steady state
            CB1(j) = b(m);          % if condition satisfy assign the value
            m = L-1;                % move to next value
            end
        end
        for m = 1: L-1
            if c(m)-c(m+1) < 0.01   % check for steady state
            CA2(j) = c(m);          % if condition satisfy assign the value
            m = L-1;                % move to next value
            end
        end
        for m = 1: L-1
            if d(m)-d(m+1) < 0.01    % check for steady state
            CB2(j) = d(m);           % if condition satisfy assign the value
            m = L-1;                 % move to next value
            end
        end
  
end
end

figure()
plot3(k,tau,CA1,"LineWidth",3)
hold on
plot3(k,tau,CB1,"LineWidth",3)
hold on
plot3(k,tau,CA2,"LineWidth",3)
hold on
plot3(k,tau,CB2,"LineWidth",3)
xlabel('k (1/min')
ylabel('tau (min)')
zlabel('Concentration (mol/L)')
legend('Ca1','Cb1','Ca2','Cb2','Location','best','Orientation','horizontal')
title("Conc vs tau vs k");



function dydt = odefcn(t,y,tau,k,Cao)
  dydt = zeros(4,1);
  dydt(1) =  1/tau*(Cao-y(1))-k*y(1);
  dydt(2) = -1/tau.*y(2)+k*y(1);
  dydt(3) =  1/tau*(y(1)-y(3))-k*y(3);
  dydt(4) =  1/tau*(y(2)-y(4))+k*y(3);
end
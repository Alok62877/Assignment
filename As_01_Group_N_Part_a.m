%% Assignment 01 GROUP - N
   % 21CH60R52 Alok Ranjan
   % 21CH60R53 Rajat Gupta
   % 21CH60R54 Mayalekshmi S
%% MATLAB code for the solution of Initial Value ODEs Part (a)
%% parameters 
clc
k = 0.12;% 1/min
tau = 5;% min
%% initial condition
Cao = 20;% mol/Lit
%% Defining ODEs function
tspan = [0 10]; % time span in minutes
y0 = [20,0,0,0]; % initial conditions of each species
[t,y] = ode45(@(t,y) odefcn(t,y,tau,k,Cao), tspan,y0);
%% Slicing Individual resuls from solution matrix
Ca1 = y(:,1);% concentration of A1 in given time span
Cb1 = y(:,2);% concentration of B1 in given time span
Ca2 = y(:,3);% concentration of A2 in given time span
Cb2 = y(:,4);% concentration of B2 in given time span
%% Plots
figure(1)
plot(t,Ca1,'-o');
hold on
plot(t,Cb1,'-*');
grid on
legend('Ca1','Cb1','Location','best','Orientation','horizontal')
xlabel('Time (min) ');
ylabel('Concentration (mol/L)');
title('Reactor 01 : Conc. Vs t');
figure(2)
plot(t,Ca2,'-o');
hold on
plot(t,Cb2,'-*');
grid on
legend('Ca2','Cb2','Location','best','Orientation','horizontal')
xlabel('Time (min) ');
ylabel('Concentration (mol/L)');
title('Reactor 02 : Conc. Vs t');
figure()
plot(t,y);
xlabel('Time (min) ');
ylabel('Concentration (mol/L)'); 
legend('Ca1','Cb1','Ca2','Cb2','Location','best','Orientation','horizontal')
%% Difining constant for steady state calculation
a = y(end,1);
b = y(end-1,1);
c = y(end,2);
d = y(end-1,2);
e = y(end,3);
f = y(end-1,3);
g = y(end,4);
h = y(end-1,4);
%% Loop to calculate individual species steady state
if abs(a-b) < 0.001 
    disp('Steady state of Ca1 is :')
    disp(a)
else
    disp('Steady state not reached for Ca1')
end   
if abs(c-d) < 0.001 
    disp('Steady state of Cb1 is :')
    disp(c)
else
    disp('Steady state not reached for Cb1')
end  
if abs(e-f) < 0.001 
    disp('Steady state of Ca2 is :')
    disp(e)
else
    disp('Steady state not reached for Ca2')
end  
if abs(g-h) < 0.001 
    disp('Steady state of Cb2 is :')
    disp(g)
else
    disp('Steady state not reached for Cb2')
    disp('Try increasing the time span for Steady state')
end  
%
function dydt = odefcn(~,y,tau,k,Cao)
  dydt = zeros(4,1);
  dydt(1) =  1/tau*(Cao-y(1))-k*y(1);
  dydt(2) = -1/tau.*y(2)+k*y(1);
  dydt(3) =  1/tau*(y(1)-y(3))-k*y(3);
  dydt(4) =  1/tau*(y(2)-y(4))+k*y(3);
end
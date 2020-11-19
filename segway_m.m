
Tfinal=1; % sets run time 
x0=[0 0 210*pi/180 0]; % intial conditions 
u0=0; % sets initial input to 0 
options=odeset('Stats','on');
[t,y]=ode45(@segode, [0 Tfinal], x0, options, u0); % solves ode with T as the input

close all 

plot(t,y(:,[1])); % plots x position vs time
xlabel('time(s)');
ylabel('x(m)');
title('x vs. t at input=0');
hold on 

[t1,y1]=ode45(@segode2, [0 Tfinal], x0, options, u0); % solves ode with V as the input
plot(t1,y1(:,[1])); % plots x position vs time
legend('input T', 'input V')

%% 
% plots alpha vs time for both sets of odes
close all 
plot(t,y(:,[3])*180/pi);
hold on 
plot(t1,y1(:,[3])*180/pi);
title('alpha vs. t at input=0');
xlabel('time(s)');
ylabel('alpha(degrees)');
legend('input T', 'input V')

%% 
% calculates the A and B matrixes for the V input ode
xs = [0 0 0 0];  % intial conditions 
us=0;
[A B]=GetLinModFtxu(@segode2, t1, xs, us)  

Q=100*[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
R=1;
K_lqr=lqr(A,B,Q,R); % calculates gain using lqr function 
Rw=.0216; % sets wheel radius (m)

%% 
t_stop = 2;
close all 
X0=[0; 0; 2*pi/180; 0]; % intial conditions 
% runs linear simulation 
sim('seglinear.slx');
% plots x position vs time
plot(tsim, xsim(:,[1])); 
title('linear sim');
xlabel('time(s)');
ylabel('x(m)');

%% 
% plots alpha vs time
close all 
plot(tsim, xsim(:,[3])*180/pi);
title('linear sim');
xlabel('time(s)');
ylabel('alpha(degrees)');

%% 
close all
% plots control effort vs time
plot(tsim, usim)
title('linear sim');
xlabel('time(s)');
ylabel('control effort(V)');

%% 
close all
t_stop2 = 2;
% runs non-linear simulation 
sim('segnonlinear.slx');
% plots x position vs time
plot(t_out, xsim_out(:,[1]));
title('non-linear sim');
xlabel('time(s)');
ylabel('x(m)');

%% 
close all
% plots alpha vs time
plot(t_out, xsim_out(:,[3])*180/pi);
title('no-linear sim');
xlabel('time(s)');
ylabel('alpha(degrees)');

%% 
% plots control effort vs time
close all
plot(t_out, u_out)
title('non-linear sim');
xlabel('time(s)');
ylabel('control effort(V)');


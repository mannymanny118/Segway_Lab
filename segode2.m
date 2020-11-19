function xdot=segode2(~,x,u)
x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
g=9.81;
lp=0.095;
mp=.187;
mw=0.036;
Rm=5.2;
Rw=.0216; 
Iw=(1/2)*mw*Rw^2
Ip=mw*lp^2;
Kb=0.495;
Kt=.32; 

T=(Kt*u/Rm)+(Kb*Kt*x2/(Rw*Rm)) +(Kb*Kt*x4/Rm);

c=[-1 lp*cos(x3) -1/mp 0 0 0;
    mw 0 -1 0 0 1;
    0 lp*sin(x3) 0 -1/mp 0 0;
    0 0 0 1 1 0;
    0 0 -lp*cos(x3) -lp*sin(x3) 0 0;
    -Iw/Rw 0 0 0 0 Rw];

b=[lp*(x4^2)*sin(x3);
    0;
    g-lp*(x4^2)*cos(x3);
    mw*g
    T;
    T];

z=inv(c)*b;
xdot=[x2; z(1); x4; z(2)];
end 
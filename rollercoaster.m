clear;
clc;
h0 = 125;
m = 1;
g = 9.8;
t = linspace(0,3*pi/4,100);
R = 50;
r = 5;
lR = 15;
tR = 5;

%Element 1 - valley
x = -R*cos(t);
y = 0.*t;
z = h0-R*sin(t);

%Tangential component slope
Tx = R*sin(t);
Ty = 0.*t;
Tz = -R*cos(t);
Tm = (Tx.^2 + Ty.^2 + Tz.^2).^(.5);


%Normal component 
Nx = R*cos(t);
Ny = 0.*(t);
Nz = R*sin(t);
Nm = (Nx.^2 + Ny.^2 + Nz.^2).^(.5);
nx = Nx./Nm;
ny = Ny./Nm;
nz = Nz./Nm;

%Normal acceleration of circle
v = getSpeed(z,h0);
an = v.^2/R;

%Normal component of gravity
theta = atan(abs(nz./nx));
thetaN = pi/2 - theta;
Ng = cos(thetaN)*g;
Norm = (Ng+an)*m;

%G's
G = Norm./(m*g);

%Element 2 - hill
theta0 = pi/4;
v0 = getSpeed(z(end),h0);
t2 =linspace(0,3.788,100);
x2 = v0*cos(theta0)*t2 + x(end);
y2 = 0.*t2 + y(end);
z2 = v0*sin(theta0)*t2 + .5*-g*t2.^2 + z(end);

%Transition
t3 = linspace(pi/4,pi/2,10);
x3 = -r*cos(t3)+x2(end)+cos(pi/4)*r;
y3 = 0.*t3 + y2(end);
z3 = -r*sin(t3)+z2(end)+sin(pi/4)*r;

%Straight section
t4 = linspace(0,20,100);
x4 = t4 + x3(end);
y4 = 0.*t4 + y3(end);
z4 = 0.*t4 + z3(end);

%Element 3 - Loop
t5 = linspace(0,2*pi,100);
x5 = lR*sin(t5) + x4(end);
y5 = (1/(2*pi)).*t5 + y4(end);
z5 = -lR*cos(t5) + z4(end) + lR;

%Straight section
t6 = linspace(0,20,100);
x6 = t6 + x5(end);
y6 = 0.*t6 + y5(end);
z6 = 0.*t6 + z5(end);

%Banked turn
t7 = linspace(0,pi/2,50);
x7 = tR*sin(t7) + x6(end);
y7 = -tR*cos(t7) + y6(end) + tR;
z7 = 0.*t7 + z6(end);

%Transition

%Downward slope

%Transition

%Braking zone

Xfin = [x,x2,x3,x4,x5,x6,x7];
Yfin = [y,y2,y3,y4,y5,y6,y7];
Zfin = [z,z2,z3,z4,z5,z6,z7];
Vfin = getSpeed(Zfin,h0);

colormap(hsv)
patch([Xfin nan],[Yfin nan],[Zfin nan],[Vfin nan],'FaceColor','none','EdgeColor','interp','LineWidth',2);
colorbar
view(3)
xlim([-100,200]);
ylim([-150,150]);
zlim([0,150]);

function v = getSpeed(h,h0)
    v = (2*9.8*(h0-h)).^(.5);
end
clear;
clc;
close all;
h0 = 125;
m = 1;
g = 9.8;
t = linspace(0,3*pi/4,100);
R = 50;
r = 25;
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


%Normal acceleration component 
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

%Normal force components
theta = atan(abs(nz./nx));
Ng = g*sin(theta);
Normx = nx.*an*m;
Normy = ny.*an*m;
Normz = (nz.*an+Ng)*m;

%Element 2 - hill
theta0 = pi/4;
v0 = getSpeed(z(end),h0);
t2 =linspace(0,3.788,100);
x2 = v0*cos(theta0)*t2 + x(end);
y2 = 0.*t2 + y(end);
z2 = v0*sin(theta0)*t2 + .5*-g*t2.^2 + z(end);

%Normal force components
Normx2 = 0.*t2;
Normy2 = 0.*t2;
Normz2 = 0.*t2;

%Transition
t3 = linspace(pi/4,pi/2,50);
x3 = -r*cos(t3)+x2(end)+cos(pi/4)*r;
y3 = 0.*t3 + y2(end);
z3 = -r*sin(t3)+z2(end)+sin(pi/4)*r;

%Tangential component slope
Tx3 = r*sin(t3);
Ty3 = 0.*t3;
Tz3 = -r*cos(t3);
Tm3 = (Tx3.^2 + Ty3.^2 + Tz3.^2).^(.5);


%Normal acceleration component 
Nx3 = r*cos(t3);
Ny3 = 0.*(t3);
Nz3 = r*sin(t3);
Nm3 = (Nx3.^2 + Ny3.^2 + Nz3.^2).^(.5);
nx3 = Nx3./Nm3;
ny3 = Ny3./Nm3;
nz3 = Nz3./Nm3;

%Normal acceleration of circle
v3 = getSpeed(z3,h0);
an3 = v3.^2/r;

%Normal force components
theta3 = atan(abs(nz3./nx3));
Ng3 = g*sin(theta3);
Normx3 = nx3.*an3*m;
Normy3 = ny3.*an3*m;
Normz3 = (nz3.*an3+Ng3)*m;

%Straight section
t4 = linspace(0,20,100);
x4 = t4 + x3(end);
y4 = 0.*t4 + y3(end);
z4 = 0.*t4 + z3(end);

Normx4 = 0.*t4*m;
Normy4 = 0.*t4*m;
Normz4 = (0.*t4+g)*m;

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
Normxfin = [Normx, Normx2, Normx3, Normx4];
Normyfin = [Normy, Normy2, Normy3, Normy4];
Normzfin = [Normz, Normz2, Normz3, Normz4];

%G's
Gx = Normxfin./(m*g);
Gy = Normyfin./(m*g);
Gz = Normzfin./(m*g);
G = (Gx.^2+Gy.^2+Gz.^2).^(.5);

Xfin = [x,x2,x3,x4,x5,x6,x7];
Yfin = [y,y2,y3,y4,y5,y6,y7];
Zfin = [z,z2,z3,z4,z5,z6,z7];
Vfin = getSpeed(Zfin,h0);
figure(1);
colormap(hsv)
patch([Xfin nan],[Yfin nan],[Zfin nan],[Vfin nan],'FaceColor','none','EdgeColor','interp','LineWidth',2);
colorbar
view(3)
xlim([-100,200]);
ylim([-150,150]);
zlim([0,150]);
figure(2);
plot(G);
function v = getSpeed(h,h0)
    v = (2*9.8*(h0-h)).^(.5);
end
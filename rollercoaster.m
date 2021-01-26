clear;
clc;
close all;
h0 = 125;
m = 1;
g = 9.8;
t = linspace(0,3*pi/4,100);
R = 50;
r = 45;
r2 = 15;
lR = 20;
tR = 20;

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
y5 = (1/(pi)).*t5 + y4(end);
z5 = -lR*cos(t5) + z4(end) + lR;

%Tangential component slope
Tx5 = lR*cos(t5);
Ty5 = (1/(pi))*ones(1,length(t5));
Tz5 = lR*sin(t5);
Tm5 = (Tx5.^2 + Ty5.^2 + Tz5.^2).^(.5);


%Normal acceleration component 
Nx5 = -lR*sin(t5);
Ny5 = 0*ones(1,length(t5));
Nz5 = lR*cos(t5);
Nm5 = (Nx5.^2 + Ny5.^2 + Nz5.^2).^(.5);
nx5 = Nx5./Nm5;
ny5 = Ny5./Nm5;
nz5 = Nz5./Nm5;

%Normal acceleration of circle
v5 = getSpeed(z5,h0);
an5 = v5.^2/lR;

%Normal force components
theta5 = atan(abs(nz5./nx5));
Ng5 = g*sin(theta5);
Normx5 = nx5.*an5*m;
Normy5 = ny5.*an5*m;
Normz5 = (nz5.*an5+Ng5)*m;

%Straight section
t6 = linspace(0,20,100);
x6 = t6 + x5(end);
y6 = 0.*t6 + y5(end);
z6 = 0.*t6 + z5(end);

Normx6 = 0.*t6*m;
Normy6 = 0.*t6*m;
Normz6 = (0.*t6+g)*m;

%Banked turn
t7 = linspace(0,pi,50);
x7 = tR*sin(t7) + x6(end);
y7 = -tR*cos(t7) + y6(end) + tR;
z7 = 0.*t7 + z6(end);

v7 = getSpeed(z7,h0);
an7 = v7.^2/tR;

%Tangential component slope
Tx7 = tR*cos(t7);
Ty7 = tR*sin(t7);
Tz7 = 0.*t7;

%Normal acceleration component 
Nx7 = -tR*sin(t7);
Ny7 = tR*cos(t7);
Nz7 = 0.*t7;
Nm7 = (Nx7.^2 + Ny7.^2 + Nz7.^2).^(.5);
nx7 = Nx7./Nm7;
ny7 = Ny7./Nm7;
nz7 = Nz7./Nm7;

Normx7 = nx7.*an7*m;
Normy7 = ny7.*an7*m;
Normz7 = (0.*t7+g)*m;


%Transition
t8 = linspace(pi/2,5*pi/6,100);
x8 = r2*cos(t8) + cos(pi/2)*r2 + x7(end);
y8 = 0.*t8 + y7(end);
z8 = r2*sin(t8) - sin(pi/2)*r2 + z7(end);


%Downward slope

t9 = linspace(0,30,100);
x9 = -cos(pi/3).*t9 + x8(end);
y9 = 0.*t9 + y8(end);
z9 = -sin(pi/3)*t9 + z8(end);

%Transition
rf = h0-z9(end);
t10 = linspace(11*pi/6,3*pi/2,100);
x10 = rf*cos(t10) - cos(11*pi/6)*rf + x9(end);
y10 = 0.*t10 + y9(end);
z10 = rf*sin(t10) - sin(11*pi/6)*rf + z9(end);

%Braking zone
t11 = linspace(0,60,100);
x11 = -t6 + x10(end);
y11 = 0.*t6 + y10(end);
z11 = 0.*t6 + z10(end);

Normxfin = [Normx, Normx2, Normx3, Normx4, Normx5, Normx6, Normx7];
Normyfin = [Normy, Normy2, Normy3, Normy4, Normy5, Normy6, Normy7];
Normzfin = [Normz, Normz2, Normz3, Normz4, Normz5, Normz6, Normz7];

%G's
Gx = Normxfin./(m*g);
Gy = Normyfin./(m*g);
Gz = Normzfin./(m*g);
G = (Gx.^2+Gy.^2+Gz.^2).^(.5);

Xfin = [x,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11];
Yfin = [y,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11];
Zfin = [z,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11];
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
plot(Gx);
hold on;
plot(Gy);
plot(Gz);

function v = getSpeed(h,h0)
    v = (2*9.8*(h0-h)).^(.5);
end
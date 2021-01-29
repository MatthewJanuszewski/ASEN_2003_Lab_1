clear;
clc;
close all;
h0 = 125;
m = 1;
g = 9.8;
R = 42;
r = 49;
r2 = 40;
lR = 20;
tR = 20;
Gupdown = zeros(1,1100);
Glat = zeros(1,1100);
Gfrontback = zeros(1,1100);

%Element 1 - valley
t = linspace(0,3*pi/4,100);
x = -R*cos(t);
y = 0.*t;
z = h0-R*sin(t);
s1 = (3*pi/4)*R;

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


Gfrontback(1:100) = ((Nm+(Tz./Tm)*g)/g);
Gupdown(1:100) = ((an+nz*g)/g);

%Element 2 - hill
theta0 = pi/4;
v0 = getSpeed(z(end),h0);
t2 =linspace(0,3.788,100);
x2 = v0*cos(theta0)*t2 + x(end);
y2 = 0.*t2 + y(end);
z2 = v0*sin(theta0)*t2 + .5*-g*t2.^2 + z(end);

%z2 parameterized in terms of x2
zeq = tan(theta0)*(x2-x(end))+.5*-g*((x2-x(end))/(v0*cos(theta0))).^2+z(end);
dzdx = tan(theta0)+((.5*-g)/((v0*cos(theta0))^2))*2*(x2-x(end));
eq = @(x2) sqrt(1+(tan(theta0)+((.5*-g)/((v0*cos(theta0))^2))*2*(x2-x(end))).^2);
%Length calculation
s2 = integral(eq,x2(1),x2(end));

%Normal force components
Normx2 = 0.*t2;
Normy2 = 0.*t2;
Normz2 = 0.*t2;

Gfrontback(101:200) = 0;
Gupdown(101:200) = 0;

%Transition
t3 = linspace(pi/4,pi/2,100);
x3 = -r*cos(t3)+x2(end)+cos(pi/4)*r;
y3 = 0.*t3 + y2(end);
z3 = -r*sin(t3)+z2(end)+sin(pi/4)*r;
s3 = pi/4 * r;
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

Gfrontback(201:300) = ((Nm3+(Tz3./Tm3)*g)/g);
Gupdown(201:300) = (an3+nz3*g)/g;

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
s4 = x4(end)-x4(1);
Normx4 = 0.*t4*m;
Normy4 = 0.*t4*m;
Normz4 = (0.*t4+g)*m;

Gfrontback(301:400) = 0;
Gupdown(301:400) = 1;


%Element 3 - Loop
t5 = linspace(0,2*pi,100);
x5 = lR*sin(t5) + x4(end);
y5 = (1/(pi)).*t5 + y4(end);
z5 = -lR*cos(t5) + z4(end) + lR;
s5 = sqrt((y5(end)-y5(1))^2+(2*pi*lR)^2);
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

Gfrontback(401:500) = ((Nm5+(Tz5./Tm5)*g)/g);
Gupdown(401:500) = (an5+nz5*g)/g;


%Straight section
t6 = linspace(0,30,100);
x6 = t6 + x5(end);
y6 = 0.*t6 + y5(end);
z6 = 0.*t6 + z5(end);
s6 = x6(end)-x6(1);

Normx6 = 0.*t6*m;
Normy6 = 0.*t6*m;
Normz6 = (0.*t6+g)*m;

Gfrontback(501:600) = 0;
Gupdown(501:600) = 1;

%Banked turn
t7 = linspace(0,pi,100);
x7 = tR*sin(t7) + x6(end);
y7 = -tR*cos(t7) + y6(end) + tR;
z7 = 0.*t7 + z6(end);
s7 = pi*tR;

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

Gfrontback(601:700) = (Nm7/g);
Gupdown(601:700) = sqrt(an7.^2+g^2)/g;

%Transition
t8 = linspace(pi/2,5*pi/6,100);
x8 = r2*cos(t8) + cos(pi/2)*r2 + x7(end);
y8 = 0.*t8 + y7(end);
z8 = r2*sin(t8) - sin(pi/2)*r2 + z7(end);
s8 = pi/3 * r2;
%Tangential component slope
Tx8 = -r2*sin(t8);
Ty8 = 0.*t8;
Tz8 = r2*cos(t8);
Tm8 = (Tx8.^2 + Ty8.^2 + Tz8.^2).^(.5);


%Normal acceleration component 
Nx8 = -r2*cos(t8);
Ny8 = 0.*(t8);
Nz8 = -r2*sin(t8);
Nm8 = (Nx8.^2 + Ny8.^2 + Nz8.^2).^(.5);
nx8 = Nx8./Nm8;
ny8 = Ny8./Nm8;
nz8 = Nz8./Nm8;

%Normal acceleration of circle
v8 = getSpeed(z8,h0);
an8 = v8.^2/r2;

%Normal force components
theta8 = atan(abs(nz8./nx8));
Ng8 = g*sin(theta8);
Normx8 = nx8.*an8*m;
Normy8 = ny8.*an8*m;
Normz8 = (nz8.*an8+Ng8)*m;

Gfrontback(701:800) = (Nm8+(Tz8./Tm8)*g)/g;
Gupdown(701:800) = -(an8+nz8*g)/g;


%Downward slope

t9 = linspace(0,35,100);
x9 = -cos(pi/3).*t9 + x8(end);
y9 = 0.*t9 + y8(end);
z9 = -sin(pi/3)*t9 + z8(end);
s9 = sqrt((x(end)-x(1))^2+(z(end)-z(1))^2);

N9 = cos(pi/3)*m*g*ones(1,length(t9));
Normx9 = sin(pi/3).*N9;
Normy9 = 0.*t9;
Normz9 = cos(pi/3).*N9;

Gfrontback(801:900) = (N9/g);
Gupdown(801:900) = sin(pi/4);


%Transition
rf = 2*z9(end);
t10 = linspace(11*pi/6,3*pi/2,100);
x10 = rf*cos(t10) - cos(11*pi/6)*rf + x9(end);
y10 = 0.*t10 + y9(end);
z10 = rf*sin(t10) - sin(11*pi/6)*rf + z9(end);
s10 = pi/3 * rf;


%Tangential component slope
Tx10 = -rf*sin(t10);
Ty10 = 0.*t10;
Tz10 = rf*cos(t10);
Tm10 = (Tx10.^2 + Ty10.^2 + Tz10.^2).^(.5);


%Normal acceleration component 
Nx10 = -rf*cos(t10);
Ny10 = 0.*(t10);
Nz10 = -rf*sin(t10);
Nm10 = (Nx10.^2 + Ny10.^2 + Nz10.^2).^(.5);
nx10 = Nx10./Nm10;
ny10 = Ny10./Nm10;
nz10 = Nz10./Nm10;

%Normal acceleration of circle
v10 = getSpeed(z10,h0);
an10 = v10.^2/rf;

%Normal force components
theta10 = atan(abs(nz10./nx10));
Ng10 = g*sin(theta10);
Normx10 = nx10.*an10*m;
Normy10 = ny10.*an10*m;
Normz10 = (nz10.*an10+Ng10)*m;

Gfrontback(901:1000) = (Nm10+(Tz10./Tm10)*g)/g;
Gupdown(901:1000) = (an10+nz10*g)/g;

%Braking zone
t11 = linspace(0,100,100);
x11 = -t11 + x10(end);
y11 = 0.*t11 + y10(end);
z11 = 0.*t11 + z10(end);
v110 = getSpeed(z11(1),h0);
ax = -(v110)^2/(2*(x11(end)-x11(1)));
s11 = abs(x11(end)-x11(1));

v11 = (v110^2+2*(ax)*(x11-x11(1))).^.5;

Normx11 = ax*ones(1,length(t11))*m;
Normy11 = 0.*t11*m;
Normz11 = (0.*t11+g)*m;

Gfrontback(1001:1100) = (-ax/g);
Gupdown(1001:1100) = 1;

Normxfin = [Normx, Normx2, Normx3, Normx4, Normx5, Normx6, Normx7, Normx8, Normx9, Normx10, Normx11];
Normyfin = [Normy, Normy2, Normy3, Normy4, Normy5, Normy6, Normy7, Normy8, Normy9, Normy10, Normy11];
Normzfin = [Normz, Normz2, Normz3, Normz4, Normz5, Normz6, Normz7, Normz8, Normz9, Normz10, Normz11];

axis1 = linspace(0,s1,100);
axis2 = linspace(axis1(end),axis1(end)+s2,100);
axis3 = linspace(axis2(end),axis2(end)+s3,100);
axis4 = linspace(axis3(end),axis3(end)+s4,100);
axis5 = linspace(axis4(end),axis4(end)+s5,100);
axis6 = linspace(axis5(end),axis5(end)+s6,100);
axis7 = linspace(axis6(end),axis6(end)+s7,100);
axis8 = linspace(axis7(end),axis7(end)+s8,100);
axis9 = linspace(axis8(end),axis8(end)+s9,100);
axis10 = linspace(axis9(end),axis9(end)+s10,100);
axis11 = linspace(axis10(end),axis10(end)+s11,100);

axis = [axis1, axis2, axis3, axis4, axis5, axis6, axis7, axis8, axis9, axis10, axis11];

%G's
Gx = Normxfin./(m*g);
Gy = Normyfin./(m*g);
Gz = Normzfin./(m*g);
G = (Gx.^2+Gy.^2+Gz.^2).^(.5);

Xfin = [x,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11];
Yfin = [y,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11];
Zfin = [z,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11];
Stot = s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11;

Vfin = getSpeed([z,z2,z3,z4,z5,z6,z7,z8,z9,z10],h0);
Vfin = [Vfin, v11];
figure(1);
colormap(hsv)
patch([Xfin nan],[Yfin nan],[Zfin nan],[Vfin nan],'FaceColor','none','EdgeColor','interp','LineWidth',2);
title('Roller Coaster w/ Velocity');
xlabel('X Position [m]');
ylabel('Y Position [m]');
zlabel('Z Position [m]');
h = colorbar;
ylabel(h, 'Velocity [m/s]')
grid on;

view(3)
xlim([-100,200]);
ylim([-150,150]);
zlim([-50,150]);
figure(2);
plot(axis,Gfrontback);
hold on;
plot(axis,Gupdown);
plot(axis,Glat);
title('G-Force Components (Cartesian)');
xlabel('Track length [m]');
ylabel('G-Force');
legend('G-Force in front/back','G-Force in up/down','G Force in lateral');

figure(3);
title('G-Force Throughout Track');
plot(axis,G);
xlabel('Track length [m]');
ylabel('Total G-Force');

figure(4);
colormap(hsv)
patch([Xfin nan],[Yfin nan],[Zfin nan],[G nan],'FaceColor','none','EdgeColor','interp','LineWidth',2);
title('Roller Coaster w/ G-Force');
xlabel('X Position [m]');
ylabel('Y Position [m]');
zlabel('Z Position [m]');
h = colorbar;
ylabel(h, 'G-Force')
view(3)
xlim([-100,200]);
ylim([-150,150]);
zlim([-50,150]);
grid on;

function v = getSpeed(h,h0)
    v = (2*9.8*(h0-h)).^(.5);
end
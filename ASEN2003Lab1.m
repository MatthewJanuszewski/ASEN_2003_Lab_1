
%ASEN 2003 lab 1 roller coaster

clear;
clc;
h0 = 125;
m = 1;
g = 9.8;
t = linspace(0,3*pi/4,100);
R = 50;
r = 25;
R2 = 7.5;
R3 = 10;
%Element 1 - valley
x = -R*cos(t);
y = 0.*t;
z = h0-R*sin(t);



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
t4 = linspace(0,5,20);
x4 = t4 + x3(end);
y4 = 0.*t4 + y3(end);
z4 = 0.*t4 + z3(end);

%Element 3 - loop section 
t5 = linspace(0, 2*pi , 100);
x5 = R2*sin(t5)+ x4(end);
z5 = R2*-cos(t5)+ z4(end)+ R2;
y5 = (1/(2*pi)).*t5 + y4(end);

% Straight 2
t6 = linspace(0,20,50);
x6 = t6 + x5(end);
y6 = 0.*t6 + y5(end);
z6 = 0.*t6 + z5(end);

%  banked turn

t7 = linspace(0,pi,100);
x7 = R3*sin(t7) + x6(end);
y7 = -R3*cos(t7) + y6(end)+ R3;
z7 = 0.*t7 + z6(end);

% transition

t8 = linspace(pi/2,5*pi/6,100);
x8 = r*cos(t8) + cos(pi/2)*r + x7(end);
y8 = 0.*t8 + y7(end);
z8 = r*sin(t8) - sin(pi/2)*r + z7(end);

% sloped down path 

t9 = linspace(0,70,100);
x9 = -tan(60).*t9 + x8(end);
y9 = 0.*t9 + y8(end);
z9 = -t9 + z8(end);
r2 = z9(100)+z9(100);

% transition to flat
t10 = linspace(11*pi/6,3*pi/2,100);
x10 = r2*cos(t10) - cos(11*pi/6)*r2 + x9(end);
y10 = 0.*t10 + y9(end);
z10 = r2*sin(t10) - sin(11*pi/6)*r2 + z9(end);

%flat

t11 = linspace(0,60,100);
x11 = -t6 + x10(end);
y11 = 0.*t6 + y10(end);
z11 = 0.*t6 + z10(end);



 Xfin = [x,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11];
 Yfin = [y,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11];
 Zfin = [z,z2,z3,z4,z5,z6,z7,z8,z9,z10,z11];
 Vfin = getSpeed(Zfin,h0);

colormap(hsv)
patch([Xfin nan],[Yfin nan],[Zfin nan],[Vfin nan],'FaceColor','none','EdgeColor','interp','LineWidth',2); 
colorbar
view(3)


% scatter3(x,y,z)
% hold on;
% scatter3(x2,y2,z2)
% scatter3(x3,y3,z3)
% scatter3(x4,y4,z4)
% scatter3(x5,y5,z5)
% scatter3(x6,y6,z6)
% scatter3(x7,y7,z7)
% scatter3(x8,y8,z8)
% scatter3(x9,y9,z9)
% scatter3(x10,y10,z10)
xlim([-50 150]);
ylim([0 150]);
zlim([-10 150]);
function v = getSpeed(h,h0)
    v =(2*9.8*(h0-h)).^(.5);
end
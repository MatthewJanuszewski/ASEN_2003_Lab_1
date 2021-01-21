clear;
clc;
h0 = 125;
m = 1;
g = 9.8;
t = linspace(0,3*pi/4,100);
R = 50;
r = 5;
lR = 15;
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
t4 = linspace(0,100,100);
x4 = t4 + x3(end);
y4 = 0.*t4 + y3(end);
z4 = 0.*t4 + z3(end);

%Loop
t5 = linspace(0,2*pi,100);
x5 = lR*sin(t5) + x4(end);
y5 = (1/(2*pi)).*t5 + y4(end);
z5 = -lR*cos(t5) + z4(end) + lR;

scatter3(x,y,z)
hold on;
scatter3(x2,y2,z2)
scatter3(x3,y3,z3)
scatter3(x4,y4,z4)
scatter3(x5,y5,z5)
function v = getSpeed(h,h0)
    v = sqrt(2*9.8*(h0-h));
end

% CORDIC implementation for generating sin and cos of desired angle
% theta d
close all
clear all
clc
% theta resolution that determines number of rotations of CORDIC
% algorithm
N =16;
% generating a tan table and value of constant k
tableArcTan= [];
k =1;
for i=1:N
k= k* sqrt(1+(2^(-2*i)));
tableArcTan =[tableArcTan atan(2^(-i))];
end
k= 1/k;
x =zeros(1,N+1);
y =zeros(1,N+1);
theta= zeros(1,N+1);
sine= [];
cosine= [];
% Specify all the values of theta
% Theta value must be within -0.9579 and 0.9579 radians
theta_s= -0.9579;
theta_e =0.9579;
for theta_d= theta_s:.1:theta_e
% CORDIC algorithm starts here
theta(1) =theta_d;
x(1) =k;
y(1) =0;
for i =1:N,
if (theta(i) > 0)
sigma= 1;
else
sigma =-1;
end
x(i+1) =x(i) - sigma*(y(i) * (2^(-i)));
y(i+1) =y(i) + sigma*(x(i) * (2^(-i)));
theta(i+1) =theta(i) - sigma*tableArcTan(i);
end
% CORDIC algorithm ends here and computes the values of
% cosine and sine of the desired angle in y(N+1) and
% x(N+1), respectively
cosine =[cosine x(N+1)];
sine =[sine y(N+1)];
end
%CARTESIAN TRAJECTORY GENERATION MAIN FUNCTION
%Some parts of the functions were sourced from:
% Authors: Huan Weng, Bill Hunt, Mikhail Todes, Jarvis Schultz
% Year: 2019
% Title: MATLAB/mr
% URL: https://github.com/NxRLab/ModernRobotics/blob/master/packages/MATLAB/mr
function trajectory = cartesian_traj_gen(Xs,Xf,tf, N)

%Defining the time interval
timeinterval = tf/(N-1);
trajectory = cell(1,N);

%Setting the Start and Finish Rotation and Positions
[Rs,ps] = T2Rp(Xs);
[Rf,pf] = T2Rp(Xf);

%Iterating and using Cubic Time Scaling to determine trajectory
for i = 1:N
    s = 3*((timeinterval*(i-1))/tf)^2-2*((timeinterval*(i-1))/tf)^3;
    trajectory{i} = [Rs*exp2R(so3matrix(Rs' * Rf) * s), ps + s * (pf - ps); 0, 0, 0, 1];
end
end

%SUPPORT FUNCTIONS
%Function used to separate out the rotation matirx and position vector from
%the transformantion matrix
function [R, p] = T2Rp(T)
R = T(1:3,1:3);
p = T(1:3,4);
end
%Function used to determine the rotation matrix from the exponential
%map
function [R] = exp2R(Rexp)
V =  [Rexp(3,2); Rexp(1,3); Rexp(2,1)];
theta = norm(V);
if norm(theta) < 1e-6
    R = eye(3);
else
    wmat = Rexp / theta;
    R = eye(3) + sin(theta)*wmat + (1-cos(theta))*wmat*wmat;
end
end
%Functions used to give the so(3) matrix for exponential coords.
function [so3m] = so3matrix(R)
acosi = (trace(R)-1)/2;
if acosi >= 1
    so3m = zeros(3);
elseif acosi <= -1
    if ~scalarcheck(1+R(3,3))
        wmat = (1/sqrt(2*(1+R(3,3)))) * [R(1,3); R(2,3); 1 + R(3,3)];
    elseif ~scalarcheck(1+R(2,2))
        wmat = (1/sqrt(2*(1+R(2,2)))) * [R(1,2); 1+R(2,2); R(3,2)];
    else
        wmat = (1/sqrt(2*(1+R(1,1)))) *[1+R(1,1); R(2,1); R(3,1)];
    end
    so3m = v2so3(pi * wmat);
else
    theta = acos(acosi);
    so3m  = theta * (1 / (2 * sin(theta))) * (R-R');
end
end
%Function used to convert the angular velocity vector to a skew symmetric matrix in so(3)
function so3M = v2so3(w)
so3M = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
end
%Function to check if scalar value is too small
function check = scalarcheck(scalar)
check = norm(scalar) < 1e-6;
end

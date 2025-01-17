%INVERSE KINEMATICS MAIN FUNCTION
%Some parts of the functions were sourced from:
% Authors: Huan Weng, Bill Hunt, Mikhail Todes, Jarvis Schultz
% Year: 2019
% Title: MATLAB/mr
% URL: https://github.com/NxRLab/ModernRobotics/blob/master/packages/MATLAB/mr

function [t, sln] = ik_body(X,init_guess)

% Establishing an initial guess for the joint angles 
t = init_guess;

% Setting the end-effector goal configuration
Tgoal = X;

% Specifiying error values for the end-effector orientation and position
e_w = deg2rad(0.1);
e_v = 0.01;

% Finding the body twist 
[B, Tb] = fk_body(t);
Bmat = T2exp(invT(Tb) * Tgoal);
Vb = [Bmat(3,2); Bmat(1,3); Bmat(2,1); Bmat(1:3,4)];
%Success Check for the body twist
sln = norm(Vb(1:3)) > e_w || norm(Vb(4:6)) > e_v;

% Using the iterative Newton-Raphson Method
iter = 0;
while sln && iter < 500
    % Incrementing the loop iteration
    iter = iter + 1;
    
    % Calculating body jacobian
    J = calcJ(B, t);

    % Updating the joint angles
    t = checklim(t + pinv(J)*Vb);
    
    % Calculating the new body twist and check for success
    [~, Tb] = fk_body(t);
    Bmat = T2exp(invT(Tb) * Tgoal);
    Vb = [Bmat(3,2); Bmat(1,3); Bmat(2,1); Bmat(1:3,4)];
    sln = norm(Vb(1:3)) > e_w || norm(Vb(4:6)) > e_v;
end
sln = ~sln;
end

%SUPPORT FUNCTIONS

%Function used to ensure that joints do not move beyond rotational limits
function [tlim] = checklim(t)
tlim = t;

% Check limits for 360 degree joints
% tlim(1) = mod(tlim(1), 2*pi);
% tlim(4) = mod(tlim(4), 2*pi);
% tlim(6) = mod(tlim(6), 2*pi);

% Check limits for 180 degree joints
if tlim(2) < 0
    tlim(2) = 0;
elseif tlim(2) > pi
    tlim(2) = pi;
end

if tlim(3) < 0
    tlim(3) = 0;
elseif tlim(3) > pi
    tlim(3) = pi;
end

if tlim(5) < 0
    tlim(5) = 0;
elseif tlim(5) > pi
    tlim(5) = pi;
end
end

%Function used to determine the Body Jacobian 
function [J] = calcJ(B,t)
J = B;
T = eye(4);

for i = length(t)-1:-1:1   
    V = -1*B(:, i+1)*t(i+1);
    Vmat = [0      -V(3)   V(2)   V(4);
            V(3)   0       -V(1)  V(5);
            -V(2)  V(1)    0      V(6);
            0      0       0      0];


    T = T * exp2T(Vmat);
    
    R = T(1:3,1:3);
    P = T(1:3,4);
    Pskew = [0      -P(3)   P(2);
             P(3)   0       -P(1);
             -P(2)  P(1)    0];
    Tadj = [R         zeros(3);
            Pskew*R   R];

	J(:, i) = Tadj * B(:, i);
end
end

%Function used to find the Inverse Matrix for the Transformation matrix
function [Tinv] = invT(T)
Tinv = [transpose(T(1:3,1:3)) -transpose(T(1:3,1:3))*T(1:3,4);
        0 0 0                 1];
end

%Function used to define the transformation matrix exponential mapping
function [Texp] = T2exp(T)
wmat = R2exp(T(1:3,1:3));

if isequal(wmat, zeros(3))
    Texp = [zeros(3) T(1:3, 4); 
              0 0 0    0];
else
    theta = acos((trace(T(1:3,1:3)) - 1) / 2);
    Texp = [wmat (eye(3)-wmat/2 + (1/theta-cot(theta/2)/2)*wmat*wmat/theta)*T(1:3,4);
            0    0 0 0];    
end
end

%Function used to find an exponential mapping for a rotation matrix
function [Rexp] = R2exp(R)
temp = (trace(R) - 1) / 2;

if temp >= 1
    Rexp = zeros(3);
elseif temp <= -1
    if ~(norm(1 + R(3, 3)) < 1e-6)
        w = (1 / sqrt(2 * (1 + R(3, 3)))) * [R(1, 3); 
                                             R(2, 3); 
                                             1 + R(3, 3)];
    elseif ~(norm(1 + R(2, 2)) < 1e-6)
        w = (1 / sqrt(2 * (1 + R(2, 2)))) * [R(1, 2); 
                                             1 + R(2, 2); 
                                             R(3, 2)];
    else
        w = (1 / sqrt(2 * (1 + R(1, 1)))) * [1 + R(1, 1); 
                                             R(2, 1); 
                                             R(3, 1)];
    end
    Rexp = [0         -pi*w(3)   pi*w(2);
            pi*w(3)   0          -pi*w(1);
            -pi*w(2)  pi*w(1)    0];
else
	theta = acos(temp);
    Rexp = theta * (1 / (2 * sin(theta))) * (R - R');
end
end

%Function used to determine the transformation matrix from the exponential
%map
function [T] = exp2T(Texp)
V =  [Texp(3,2); Texp(1,3); Texp(2,1)];
theta = norm(V);

if norm(theta) <  1e-6
    T = [eye(3) Texp(1:3,4); 
         0 0 0  1];
else
    wmat = Texp(1:3,1:3) / theta; 

    T = [exp2R(Texp(1:3,1:3)) (eye(3)*theta+(1-cos(theta))*wmat+(theta-sin(theta))*wmat*wmat)*Texp(1:3,4)/theta;
         0 0 0                1];
end
end

%Function used to determine the rotation matrix from the exponential map
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
%INVERSE DYNAMICS MAIN FUNCTION
%Some parts of the functions were sourced from:
% Authors: Huan Weng, Bill Hunt, Mikhail Todes, Jarvis Schultz
% Year: 2019
% Title: MATLAB/mr
% URL: https://github.com/NxRLab/ModernRobotics/blob/master/packages/MATLAB/mr
function [tau] = inv_dyn(t,dt,ddt,g)

%Defining the Robot Link Parameters
%Link Lengths
L0 = 0.7;
L1 = 0.3; 
L2 = 0.6;
L3 = 0.61;
L4 = 0.2;
L5 = 0.325;
L6 = 0.1;
EE = 0.2;

% y-axis distances between the joints (Anti-parallel)
W1 = 0; % distance between base and joint 1
W2 = 0; % distance between joint 1 and 2
W3 = -L2; % distance between joint 2 and 3
W4 = 0; % distance between joint 3 and 4
W5 = 0; % distance between joint 4 and 5
W6 = L5; % distance between joint 5 and 6

% Link Radii
rb = ((0.3+0.25)/2)/2;
rL1 = 0.25/2;
rL2 = 0.25/2;
rL3 = ((0.25+0.2)/2)/2;
rL4 = 0.2/2;
rL5 = 0.09/2;
rL6 = 0.16/2;

%Link Masses (kg)
m0 = 58.82122;
m1 = 12.14307;
m2 = 27.51008;
m3 = 22.95120;
m4 = 5.34717;
m5 = 3.18720;
m6 = 0.27655;

%Defining the End-Effector Wrench 
Ftip =[0;0;0;0;0;0];

%Defining positions of the center of mass for each link
%Position of CoM for Link 1 with reference to World Frame (No rotation)
M0L1 = [1  0  0  0;
         0  1  0  0;
         0  0  1  L0+(L1/2);
         0  0  0  1];
%Position of CoM for Link 2 with reference to Link 1 (+ve y rotation by 90 degrees)
ML1L2 = [0  0  1  0;
         0  1  0  -L2/2;
         -1  0  0  L1/2;
         0  0  0  1];
%Position of CoM for Link 3 with reference to Link 2 (No rotation)
ML2L3 = [1  0  0  L3/2;
         0  1  0  -L2/2;
         0  0  1  0;
         0  0  0  1];
%Position of CoM for Link 4 with reference to Link 3 (+ve y rotation by 90 degrees)
ML3L4 = [0  0  1  (L3/2)+(L4/2);
         0  1  0  0;
        -1  0  0  0;
         0  0  0  1];
%Position of CoM for Link 5 with reference to Link 4 (-ve y rotation by 90 degrees)
ML4L5 = [0  0  -1  0;
         0  1  0  L5/2;
         1  0  0  L4/2;
         0  0  0  1];
%Position of CoM for Gripper Base with Reference to Link 5 (+ve x rotation by 90 degrees)
ML5L6 = [1  0  0  0;
         0  0  -1  (L5/2)+(L6/2);
         0  1  0  0;
         0  0  0  1];
%Position of End Effector with respect to Gripper Base (No Rotation)
ML6EE = [1  0  0  0;
        0  1  0  0;
        0  0  1  (L6/2)+ EE;
        0  0  0  1];

Ml = cat(3, M0L1, ML1L2, ML2L3, ML3L4, ML4L5, ML5L6, ML6EE);

%Defining the Inertia Matrices for Each Link
In1 = [m1*(3*rL1^2+L1^2)/12,m1*(3*rL1^2+L1^2)/12, (m1*rL1^2)/2];
In1m1 = [In1,m1,m1,m1];
In2 = [m2*(3*rL2^2+L2^2)/12,m2*(3*rL2^2+L2^2)/12, (m2*rL2^2)/2];
In2m2 = [In2,m2,m2,m2];
In3 = [m3*(3*rL3^2+L3^2)/12,m3*(3*rL3^2+L3^2)/12, (m3*rL3^2)/2];
In3m3 = [In3,m3,m3,m3];
In4 = [m4*(3*rL4^2+L4^2)/12,m4*(3*rL4^2+L4^2)/12, (m4*rL4^2)/2];
In4m4 = [In4,m4,m4,m4];
In5 = [m5*(3*rL5^2+L5^2)/12,m5*(3*rL5^2+L5^2)/12, (m5*rL5^2)/2];
In5m5 = [In5,m5,m5,m5];
In6 = [m6*(3*rL6^2+L6^2)/12,m6*(3*rL6^2+L6^2)/12, (m6*rL6^2)/2];
In6m6 = [In6,m6,m6,m6];

%Spatial Inertia Matrix for Each Link Relative to Corresponding Frames
G1 = diag(In1m1);
G2 = diag(In2m2);
G3 = diag(In3m3);
G4 = diag(In4m4);
G5 = diag(In5m5);
G6 = diag(In6m6);

Gl = cat(3, G1,G2,G3,G4,G5,G6);

%Screw Axes
%Joint 1
a1 = [0; 0; 0];
Sw1 = [0; 0; 1]; 
Sv1 = cross(-Sw1,a1);
S1 = [Sw1; Sv1];

%Joint 2
a2 = [0; 0; L0+L1];
Sw2 = [-1; 0; 0];
Sv2 = cross(-Sw2,a2);
S2 = [Sw2; Sv2];

%Joint 3
a3 = [0; W3; L0+L1];
Sw3 = [-1; 0; 0];
Sv3 = cross(-Sw3,a3);
S3 = [Sw3; Sv3];

%Joint 4
a4 = [0; W3; L0+L1-L3];
Sw4 = [0; 0; 1];
Sv4 = cross(-Sw4,a4);
S4 = [Sw4; Sv4];

%Joint 5
a5 = [0; W3; L0+L1-L3-L4];
Sw5 = [-1; 0; 0];
Sv5 = cross(-Sw5,a5);
S5 = [Sw5; Sv5];

%Joint 6
a6 = [0; W3+W6; L0+L1-L3-L4];
Sw6 = [0; 1; 0];
Sv6 = cross(-Sw6,a6);
S6 = [Sw6; Sv6];

%List of Screw Axes
S = [S1 S2 S3 S4 S5 S6];

% Initialise
n = size(t,1);
Mn = eye(4);
An = zeros(6, n);
AdTn = zeros(6,6,n+1);
Vn = zeros(6,n+1);
Vdn = zeros(6,n+1);

Vdn(4:6,1)= -g;
AdTn(:,:,n+1) = Adj(invT(Ml(:,:,n+1)));
Fn = Ftip;

tau = zeros(n,1);

%Forward Iteration
for i=1:n
    Mn = Mn * Ml(:,:,i);
    An(:,i) = Adj(invT(Mn)) * S(:,i);
    AdTn(:,:,i) = Adj(exp2T(v2se3(An(:,i) * -t(i)))* invT(Ml(:,:,i)));
    Vn(:,i+1) = AdTn(:,:,i) * Vn(:,i) + An(:,i) *dt(i);
    Vdn(:,i+1) = AdTn(:,:,i) * Vdn(:,i) + An(:,i) * ddt(i) + ad(Vn(:,i+1)) * An(:,i) * dt(i);
end

%Backward Iteration
for i = n: -1: 1
    Fn = AdTn(:,:,i+1)' * Fn + Gl(:,:,i) * Vdn(:,i+1) - ad(Vn(:,i+1))' * (Gl(:,:,i) * Vn(:,i+1));
    tau(i) = Fn' * An(:,i);
end
end

%SUPPORT FUNCTIONS
%Function used to find the adjoint of the transformation matrix
function AdT = Adj(T)
[R,p] = T2Rp(T);
AdT = [R,zeros(3); v2so3(p)*R,R];
end

%Function used to separate out the rotation matirx and position vector from
%the transformantion matrix
function [R,p] = T2Rp(T)
R = T(1:3,1:3);
p = T(1:3,4);
end

%Function used to convert the angular velocity vector to a skew symmetric matrix in so(3)
function so3M = v2so3(w)
so3M = [0,-w(3),w(2); w(3),0,-w(1);-w(2),w(1),0];
end

%Function used to convert the spatial velocity vector to a matrix in se(3)
function se3M = v2se3(V)
se3M = [v2so3(V(1:3)), V(4:6);0,0,0,0];
end

%Function used to find the inverse of the transformation matrix
function [Tinv] = invT(T)
Tinv = [transpose(T(1:3,1:3)) -transpose(T(1:3,1:3))*T(1:3,4);
        0 0 0                 1];
end

%Function used to determine the transformation matrix from the exponential
%map
function [T] = exp2T(Texp)
V =  [Texp(3,2); Texp(1,3); Texp(2,1)];
theta = norm(V);

if norm(theta) <  1e-6
    T = [eye(3), Texp(1:3,4); 0 0 0  1];
else
    wmat = Texp(1:3,1:3) / theta; 

    T = [exp2R(Texp(1:3,1:3)) (eye(3)*theta+(1-cos(theta))*wmat+(theta-sin(theta))*wmat*wmat)*Texp(1:3,4)/theta;
         0, 0, 0,1];
end
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

%Function used to calculate the Lie Bracket
function adV = ad(V)
wmat = v2so3(V(1:3));
adV = [wmat, zeros(3); v2so3(V(4:6)),wmat];
end
    
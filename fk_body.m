%FORWARD KINEMATICS MAIN FUNCTION
%Some parts of the functions were sourced from:
% Authors: Huan Weng, Bill Hunt, Mikhail Todes, Jarvis Schultz
% Year: 2019
% Title: MATLAB/mr
% URL: https://github.com/NxRLab/ModernRobotics/blob/master/packages/MATLAB/mr
function [B, T] = fk_body(t)

%Establishing the Link Lengths (in the z-direction)

L0 = 0.7;
L1 = 0.3; 
L2 = 0.6;
L3 = 0.61;
L4 = 0.2;
L5 = 0.325; 

% Configuration matrix of the end-effector with reference to the base 
% Rotation about x-axis -90 degrees 
% Position offset in z and y direction
M = [1   0    0    0;
     0   0    1    -L2+L5;
     0   -1   0    L0+L1-L3-L4;
     0   0    0    1];

% Determining the position and screw axis with respect to the end-effector
% for joint 1
a1 = [0; -L4-L3+L1+L0; -L5+L2]; %joint position
Bw1 = [0; -1; 0]; % angular component (-y)
Bv1 = cross(-Bw1,a1); %linear component
B1 = [Bw1; Bv1]; %Screw Axis

% Determining the position and screw axis with respect to the end-effector
% for joint 2
a2 = [0; -L4-L3; -L5+L2]; %joint position
Bw2 = [-1; 0; 0]; % angular component (-x)
Bv2 = cross(-Bw2,a2); %linear component
B2 = [Bw2; Bv2]; %Screw Axis

% Determining the position and screw axis with respect to the end-effector
% for joint 3
a3 = [0; -L4-L3; -L5]; %joint position
Bw3 = [-1; 0; 0];% angular component (-x)
Bv3 = cross(-Bw3,a3); %linear component
B3 = [Bw3; Bv3];%Screw Axis

% Determining the position and screw axis with respect to the end-effector
% for joint 4
a4 = [0; -L4; -L5];%joint position
Bw4 = [0; -1; 0]; % angular component (-y)
Bv4 = cross(-Bw4,a4);%linear component
B4 = [Bw4; Bv4]; %Screw Axis

% Determining the position and screw axis with respect to the end-effector
% for joint 5
a5 = [0; 0; -L5];%joint position
Bw5 = [-1; 0; 0]; % angular component (-x)
Bv5 = cross(-Bw5,a5);%linear component
B5 = [Bw5; Bv5];%Screw Axis

% Determining the position and screw axis with respect to the end-effector
% for joint 6
a6 = [0; 0; 0];%joint position
Bw6 = [0; 0; 1]; % angular component (+z)
Bv6 = cross(-Bw6,a6);%linear component
B6 = [Bw6; Bv6];%Screw Axis

%List of screw axes
B = [B1 B2 B3 B4 B5 B6];

% Using the body form of the product of exponentials to apply
% transformations along the screw axes
e1 = [eye(3)+skew_sym(Bw1)*sin(t(1))+skew_sym(Bw1)*skew_sym(Bw1)*(1-cos(t(1))) (eye(3)-(eye(3)+skew_sym(Bw1)*sin(t(1))+skew_sym(Bw1)*skew_sym(Bw1)*(1-cos(t(1)))))*cross(Bw1, Bv1)+t(1)*Bw1*transpose(Bw1)*Bv1;
      0         0           0                                      1];
e2 = [eye(3)+skew_sym(Bw2)*sin(t(2))+skew_sym(Bw2)*skew_sym(Bw2)*(1-cos(t(2))) (eye(3)-(eye(3)+skew_sym(Bw2)*sin(t(2))+skew_sym(Bw2)*skew_sym(Bw2)*(1-cos(t(2)))))*cross(Bw2, Bv2)+t(2)*Bw2*transpose(Bw2)*Bv2;
      0         0           0                                      1];
e3 = [eye(3)+skew_sym(Bw3)*sin(t(3))+skew_sym(Bw3)*skew_sym(Bw3)*(1-cos(t(3))) (eye(3)-(eye(3)+skew_sym(Bw3)*sin(t(3))+skew_sym(Bw3)*skew_sym(Bw3)*(1-cos(t(3)))))*cross(Bw3, Bv3)+t(3)*Bw3*transpose(Bw3)*Bv3;
      0         0           0                                      1];
e4 = [eye(3)+skew_sym(Bw4)*sin(t(4))+skew_sym(Bw4)*skew_sym(Bw4)*(1-cos(t(4))) (eye(3)-(eye(3)+skew_sym(Bw4)*sin(t(4))+skew_sym(Bw4)*skew_sym(Bw4)*(1-cos(t(4)))))*cross(Bw4, Bv4)+t(4)*Bw4*transpose(Bw4)*Bv4;
      0         0           0                                      1];
e5 = [eye(3)+skew_sym(Bw5)*sin(t(5))+skew_sym(Bw5)*skew_sym(Bw5)*(1-cos(t(5))) (eye(3)-(eye(3)+skew_sym(Bw5)*sin(t(5))+skew_sym(Bw5)*skew_sym(Bw5)*(1-cos(t(5)))))*cross(Bw5, Bv5)+t(5)*Bw5*transpose(Bw5)*Bv5;
      0         0           0                                      1];
e6 = [eye(3)+skew_sym(Bw6)*sin(t(6))+skew_sym(Bw6)*skew_sym(Bw6)*(1-cos(t(6))) (eye(3)-(eye(3)+skew_sym(Bw6)*sin(t(6))+skew_sym(Bw6)*skew_sym(Bw6)*(1-cos(t(6)))))*cross(Bw6, Bv6)+t(6)*Bw6*transpose(Bw6)*Bv6;
      0         0           0                                      1];
T = M*e1*e2*e3*e4*e5*e6;

end

%SUPPORT FUNCTIONS

%Screw Symmetric Matrix format
function [M_skew] = skew_sym(vec)
M_skew = [0       -vec(3)   vec(2); 
          vec(3)    0       -vec(1); 
         -vec(2)   vec(1)    0];
end
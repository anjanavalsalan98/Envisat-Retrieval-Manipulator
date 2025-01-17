% ENVISAT MANIPULATOR MAIN CODE

% PROGRAM SETUP
clear all;
close all;
ModelName = 'EA_Model';
open_system("EA_Model")
set_param(ModelName,'StopFcn','1');

set_param(ModelName, 'SimulationCommand', 'stop');

set_param(ModelName, 'BlockReduction','off');
set_param(ModelName,'StopTime','inf');
set_param(ModelName, 'simulationMode','normal');
set_param(ModelName,"EnablePacing","on");


%FORWARD KINEMATICS
[Bstow, Tstow] = fk_body([0,0,0,0,0,0]);
[Bgrapple, Tgrapple] = fk_body([0,pi/2,pi/2,0,pi/2,0]);

%TRAJECTORY GENERATION
Xs = Tstow;
Xf = Tgrapple;
time = 30;
N = 10;
trajectory = cartesian_traj_gen(Xs, Xf, time, N);

%INVERSE KINEMATICS
theta = [0;pi/2;pi/2;0;pi/2;0];
theta_matrix = [];
for i = 1:N
    [theta,success] = ik_body(trajectory{i},theta);
    if success
        theta_matrix = [theta_matrix;theta'];
    end
    
end

%VELOCITIES AND ACCELERATIONS
dtheta_matrix = zeros(size(theta_matrix,1),6);
ddtheta_matrix = zeros(size(theta_matrix,1),6);

timeinterval = time/(size(theta_matrix,1)-1);

for i = 1:size(theta_matrix,1)-1
    dtheta_matrix(i+1,:) = (theta_matrix(i+1,:)-theta_matrix(i,:))/timeinterval;
    ddtheta_matrix(i+1,:) = (ddtheta_matrix(i+1,:)-dtheta_matrix(i,:))/timeinterval;
end

% SIMULATION START
sampling_interval = transpose(0:timeinterval:(size(theta_matrix,1)-1)*timeinterval);
theta_matrix = [sampling_interval, theta_matrix];
dtheta_matrix = [sampling_interval, dtheta_matrix];
ddtheta_matrix = [sampling_interval, ddtheta_matrix];

set_param(ModelName,'StartFcn','1');
set_param(ModelName, 'SimulationCommand', 'start');
    
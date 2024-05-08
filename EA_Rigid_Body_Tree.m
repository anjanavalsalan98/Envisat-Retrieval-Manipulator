%Joint 1 DH Parameters
al0 = deg2rad(0); %rotates about common normal
d1 = 1; %offset along z-axis in normal direction (parent to child)
a0 = 0; %length of common normal between z-axes, perpendicular to both
t1_offset = deg2rad(90); % angle of rotation for x-axis along previous z-axis

%Joint 2 DH Parameters
al1 = deg2rad(-90);
d2 = 0;
a1 = 0;
t2_offset = deg2rad(180);

%Joint 3 DH Parameters
al2 = deg2rad(0);
d3 = 0;
a2 = 0.6;
t3_offset = deg2rad(0);

%Joint 4 DH Parameters
al3 = deg2rad(-90);
d4  = -0.81;
a3 = 0;
t4_offset = deg2rad(-180);

%Joint 5 DH Parameters
al4 = deg2rad(-90);
d5 = 0;
a4 = 0;
t5_offset = deg2rad(90);

%Joint 6 DH Parameters
al5 = deg2rad(90);
d6 = 0.325;
a5 = 0;
t6_offset = deg2rad(180);


mdh =[a0       al0        d1      t1_offset;
      a1       al1        d2      t2_offset;
      a2       al2        d3      t3_offset;
      a3       al3        d4      t4_offset;
      a4       al4        d5      t5_offset;
      a5       al5        d6      t6_offset];


% Create a rigid body tree object
robot = rigidBodyTree;

% Iterate through the DH parameters
bodies = cell(6,1);
joints = cell(6,1);
for i = 1:6
    bodies{i} = rigidBody(['body' num2str(i)]);
    joints{i} = rigidBodyJoint(['jnt' num2str(i)],"revolute");
    setFixedTransform(joints{i},mdh(i,:),"mdh");
    bodies{i}.Joint = joints{i};
    if i == 1 
        addBody(robot,bodies{i},"base")
    else 
        addBody(robot,bodies{i},bodies{i-1}.Name)
    end
    robot.Bodies{i}.Joint.HomePosition=mdh(i,4);
    robot.Bodies{i}.Joint.JointAxis=[0 0 1];
end

% Verify that your robot has been built properly
showdetails(robot);

% Show robot
figure(Name="EA_RBT")
show(robot);
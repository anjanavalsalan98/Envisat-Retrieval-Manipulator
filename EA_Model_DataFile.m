% Simscape(TM) Multibody(TM) version: 7.7

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(13).translation = [0.0 0.0 0.0];
smiData.RigidTransform(13).angle = 0.0;
smiData.RigidTransform(13).axis = [0.0 0.0 0.0];
smiData.RigidTransform(13).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [0 -2.4424906541753444e-15 0.69999999999999996];  % m
smiData.RigidTransform(1).angle = 3.4914813388431334e-15;  % rad
smiData.RigidTransform(1).axis = [1 0 0];
smiData.RigidTransform(1).ID = "B[EA_Base-3:-:EA_Link1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [2.0062058921534659e-18 -1.3732011227675734e-17 -1.1102230246251565e-16];  % m
smiData.RigidTransform(2).angle = 3.4914813388431334e-15;  % rad
smiData.RigidTransform(2).axis = [1 -3.5302928607839526e-16 -6.1629758220391547e-31];
smiData.RigidTransform(2).ID = "F[EA_Base-3:-:EA_Link1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [-0.045000000000000012 0.50000000000000011 -0.00084945832315796999];  % m
smiData.RigidTransform(3).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(3).axis = [0.57735026918962584 0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(3).ID = "B[EA_Link2-1:-:EA_Link1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-0.045000000000000942 1.0133387184918519e-14 0.30000000000000082];  % m
smiData.RigidTransform(4).angle = 2.094395102393197;  % rad
smiData.RigidTransform(4).axis = [0.57735026918962551 0.57735026918962629 0.57735026918962562];
smiData.RigidTransform(4).ID = "F[EA_Link2-1:-:EA_Link1-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [-0.099999999999999867 0 0.042321231116480784];  % m
smiData.RigidTransform(5).angle = 1.8849474910663015e-16;  % rad
smiData.RigidTransform(5).axis = [-1 0 -0];
smiData.RigidTransform(5).ID = "B[EA_Link3-3:-:EA_Link2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [-0.045000000000003995 -0.099999999999998646 -1.8055001937966608e-14];  % m
smiData.RigidTransform(6).angle = 2.0943951023931926;  % rad
smiData.RigidTransform(6).axis = [-0.57735026918962629 -0.57735026918962484 0.57735026918962629];
smiData.RigidTransform(6).ID = "F[EA_Link3-3:-:EA_Link2-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 0 -0.0049999999999998934];  % m
smiData.RigidTransform(7).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(7).axis = [1 0 0];
smiData.RigidTransform(7).ID = "B[EA_Link4-1:-:EA_Link3-3]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [0.50500000000000012 -1.6306400674181987e-16 -5.5511151231257827e-16];  % m
smiData.RigidTransform(8).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(8).axis = [-0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(8).ID = "F[EA_Link4-1:-:EA_Link3-3]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 0 0];  % m
smiData.RigidTransform(9).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(9).axis = [0.57735026918962584 0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(9).ID = "B[EA_Link5-1:-:EA_Link4-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [-0.044999999999992685 6.2692906421801808e-15 0.20000000000000151];  % m
smiData.RigidTransform(10).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(10).axis = [0.57735026918962573 0.57735026918962595 0.57735026918962562];
smiData.RigidTransform(10).ID = "F[EA_Link5-1:-:EA_Link4-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [-0.10418334985559985 -0.016536088725538356 -0.17463021355804353];  % m
smiData.RigidTransform(11).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(11).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962584];
smiData.RigidTransform(11).ID = "B[Gripper-2:-:EA_Link5-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [0.045000000000000095 0.1549999999999998 -2.2204460492503131e-16];  % m
smiData.RigidTransform(12).angle = 2.0943951023931957;  % rad
smiData.RigidTransform(12).axis = [0.57735026918962584 -0.57735026918962584 0.57735026918962562];
smiData.RigidTransform(12).ID = "F[Gripper-2:-:EA_Link5-1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(13).translation = [-0.13669073407180576 -0.072129837389297097 -0.092778291896871645];  % m
smiData.RigidTransform(13).angle = 0;  % rad
smiData.RigidTransform(13).axis = [0 0 0];
smiData.RigidTransform(13).ID = "RootGround[EA_Base-3]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(7).mass = 0.0;
smiData.Solid(7).CoM = [0.0 0.0 0.0];
smiData.Solid(7).MoI = [0.0 0.0 0.0];
smiData.Solid(7).PoI = [0.0 0.0 0.0];
smiData.Solid(7).color = [0.0 0.0 0.0];
smiData.Solid(7).opacity = 0.0;
smiData.Solid(7).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 58.821218640844286;  % kg
smiData.Solid(1).CoM = [5.0218146417408328e-05 -0.00014404405047229509 246.38230865861902];  % mm
smiData.Solid(1).MoI = [3107964.322016343 3506272.1699736277 1361724.8212227179];  % kg*mm^2
smiData.Solid(1).PoI = [3.2503339197826726 -1.1331654775322073 0.59247824115776471];  % kg*mm^2
smiData.Solid(1).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "EA_Base*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 12.143065451444381;  % kg
smiData.Solid(2).CoM = [-0.00048799897486901175 1.5926867886907556 165.2976075724313];  % mm
smiData.Solid(2).MoI = [199952.16360976725 231722.94302245442 104908.87692193501];  % kg*mm^2
smiData.Solid(2).PoI = [-148.10396046546256 0.40533763499333447 -0.20027156682464692];  % kg*mm^2
smiData.Solid(2).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "EA_Link1*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 27.510080043728184;  % kg
smiData.Solid(3).CoM = [3.1666437024059714e-05 183.44484394754863 -0.059686277898942021];  % mm
smiData.Solid(3).MoI = [1047451.2909342058 207564.97389193386 1061388.9863857932];  % kg*mm^2
smiData.Solid(3).PoI = [566.65183692190601 -5.9649375929739703 0.26143465699273599];  % kg*mm^2
smiData.Solid(3).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "EA_Link2*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 22.951202746230408;  % kg
smiData.Solid(4).CoM = [186.73668918640908 6.5417763338535665e-05 -0.3752793020451608];  % mm
smiData.Solid(4).MoI = [137465.54584806567 770220.06644938665 777562.82426895294];  % kg*mm^2
smiData.Solid(4).PoI = [0.24034916555370639 -2387.0470658533131 -0.36599022051381563];  % kg*mm^2
smiData.Solid(4).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "EA_Link3*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 3.1871953386922143;  % kg
smiData.Solid(5).CoM = [45.000001603152839 14.183017444183854 -4.4511541012871493e-06];  % mm
smiData.Solid(5).MoI = [19461.783390925026 9341.687227659062 14290.378260990503];  % kg*mm^2
smiData.Solid(5).PoI = [0.0016048846610554363 -0.0012131024729747527 -0.00046365085038925768];  % kg*mm^2
smiData.Solid(5).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "EA_Link5*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 5.3471660664403924;  % kg
smiData.Solid(6).CoM = [0 0 102.35583598814762];  % mm
smiData.Solid(6).MoI = [40545.547897430755 47066.524665180354 29339.436483018235];  % kg*mm^2
smiData.Solid(6).PoI = [0 0 -9.4981429485659199e-05];  % kg*mm^2
smiData.Solid(6).color = [0.9882352941176471 0.73725490196078436 0.51764705882352935];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = "EA_Link4*:*Default";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(7).mass = 0.2765503607228007;  % kg
smiData.Solid(7).CoM = [-52.081576561289793 26.943437021082758 -87.40696653610496];  % mm
smiData.Solid(7).MoI = [283.82544540312824 509.91820068852508 629.41608666067725];  % kg*mm^2
smiData.Solid(7).PoI = [1.2559441118888697 0.8766544562867894 -0.13970622133341348];  % kg*mm^2
smiData.Solid(7).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = "Gripper*:*Default";


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the CylindricalJoint structure array by filling in null values.
smiData.CylindricalJoint(1).Rz.Pos = 0.0;
smiData.CylindricalJoint(1).Pz.Pos = 0.0;
smiData.CylindricalJoint(1).ID = "";

smiData.CylindricalJoint(1).Rz.Pos = -8.3119378170568492;  % deg
smiData.CylindricalJoint(1).Pz.Pos = 0;  % m
smiData.CylindricalJoint(1).ID = "[EA_Base-3:-:EA_Link1-1]";


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(5).Rz.Pos = 0.0;
smiData.RevoluteJoint(5).ID = "";

smiData.RevoluteJoint(1).Rz.Pos = 88.079949890200368;  % deg
smiData.RevoluteJoint(1).ID = "[EA_Link2-1:-:EA_Link1-1]";

smiData.RevoluteJoint(2).Rz.Pos = 174.5126627046975;  % deg
smiData.RevoluteJoint(2).ID = "[EA_Link3-3:-:EA_Link2-1]";

smiData.RevoluteJoint(3).Rz.Pos = -61.089574191751446;  % deg
smiData.RevoluteJoint(3).ID = "[EA_Link4-1:-:EA_Link3-3]";

smiData.RevoluteJoint(4).Rz.Pos = -135.61508234124616;  % deg
smiData.RevoluteJoint(4).ID = "[EA_Link5-1:-:EA_Link4-1]";

smiData.RevoluteJoint(5).Rz.Pos = -19.881272823218143;  % deg
smiData.RevoluteJoint(5).ID = "[Gripper-2:-:EA_Link5-1]";


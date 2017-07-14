function [ vu, omega ] = calculateControlOutput( robotPose, goalPose, parameters )
%CALCULATECONTROLOUTPUT This function computes the motor velocities for a differential driven robot

% current robot position and orientation
x = robotPose(1);
y = robotPose(2);
theta = robotPose(3);

% goal position and orientation
xg = goalPose(1);
yg = goalPose(2);
thetag = goalPose(3);

% compute control quantities
rho = sqrt((xg-x)^2+(yg-y)^2);  % pythagoras theorem, sqrt(dx^2 + dy^2)
lambda = atan2(yg-y, xg-x);     % angle of the vector pointing from the robot to the goal in the inertial frame
alpha = lambda - theta;         % angle of the vector pointing from the robot to the goal in the robot frame
alpha = normalizeAngle(alpha);

% the following paramerters should be used:
% Task 2:
% parameters.Kalpha, parameters.Kbeta, parameters.Krho: controller tuning parameters
% Task 3:
% parameters.backwardAllowed: This boolean variable should switch the between the two controllers
% parameters.useConstantSpeed: Turn on constant speed option
% parameters.constantSpeed: The speed used when constant speed option is on

%STARTRM
if parameters.backwardAllowed % Backward speed allowed
    % If obstacle in "front" => go forward
    if(abs(alpha)<=pi/2)
        beta = thetag-lambda;
        Krho2 = parameters.Krho;
    else
        alpha = lambda-theta-pi;
        alpha = normalizeAngle(alpha);
        beta = thetag-lambda-pi;
        Krho2 = -parameters.Krho;
    end
else
    beta = thetag-lambda;
    Krho2 = parameters.Krho;
end
beta = normalizeAngle(beta);

vu = Krho2 * rho; % [m/s]
omega = parameters.Kalpha * alpha + parameters.Kbeta * beta; % [rad/s]

if parameters.useConstantSpeed % Constant speed enabled
    absVel = abs(vu);
    if(absVel>1e-6)
        vu = vu/absVel*parameters.constantSpeed;
        omega = omega/absVel*parameters.constantSpeed;
    end
end
%ENDRM
%STARTUNCOMMENT
% vu = TODO; % [m/s]
% omega = TODO; % [rad/s]
%ENDUNCOMMENT

end


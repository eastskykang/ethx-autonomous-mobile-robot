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

% closed loop 
Kalpha = parameters.Kalpha;
Kbeta = parameters.Kbeta;
Krho = parameters.Krho;

% state = [rho, alpha, beta]'
beta = - theta - alpha;
beta = normalizeAngle(beta);

% without backward allowance and constant speed option
vu = Krho * rho; % [m/s]
omega = Kalpha * alpha + Kbeta * beta; % [rad/s]

if parameters.backwardAllowed
    % two case
    % case1: goal point is infront of robot
    % case2: goal point is behind robot
    
    if abs(alpha) <= pi()/2
        % infront of robot
        % no difference
    else
        % behind robot
        alpha = lambda - theta - pi;
        alpha = normalizeAngle(alpha);
        beta = thetag - lambda - pi;
        
        vu = - Krho * rho;
        omega = Kalpha * alpha + Kbeta * beta;
    end
end

if parameters.useConstantSpeed
    % if velocity is not zero, use constant speed instead
    % (also angular velocity)

    % tolerance needed (for convergence)
    tol = 1e-6;
    absVel = abs(vu);
    
    if absVel > tol
        % preserve sign        
        vu = vu/absVel*parameters.constantSpeed;
        
        % for convergence (when absVel is small, turn fast)
        omega = omega/absVel*parameters.constantSpeed;
    end

end


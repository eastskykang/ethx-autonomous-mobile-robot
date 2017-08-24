clear all; clc;

% given are the functions 
%   r_BF_inB(alpha,beta,gamma) and
%   J_BF_inB(alpha,beta,gamma) 
% for the foot positon respectively Jacobian
  
r_BF_inB = @(alpha,beta,gamma)[...
    - sin(beta + gamma) - sin(beta);...
  sin(alpha)*(cos(beta + gamma) + cos(beta) + 1) + 1;...
  -cos(alpha)*(cos(beta + gamma) + cos(beta) + 1)];

J_BF_inB = @(alpha,beta,gamma)[...
                                              0,             - cos(beta + gamma) - cos(beta),            -cos(beta + gamma);...
 cos(alpha)*(cos(beta + gamma) + cos(beta) + 1), -sin(alpha)*(sin(beta + gamma) + sin(beta)), -sin(beta + gamma)*sin(alpha);...
 sin(alpha)*(cos(beta + gamma) + cos(beta) + 1),  cos(alpha)*(sin(beta + gamma) + sin(beta)),  sin(beta + gamma)*cos(alpha)];

% write an algorithm for the inverse differential kinematics problem to
% find the generalized velocities dq to follow a circle in the body xz plane
% around the start point rCenter with a radius of r=0.5 and a 
% frequeny of 0.25Hz. The start configuration is q =  pi/180*([0,-60,120])',
% which defines the center of the circle
q0 = pi/180*([0,-60,120])';
dq0 = zeros(3,1);
rCenter = r_BF_inB(q0(1),q0(2),q0(3));
radius = 0.5;
f = 0.25;
rGoal = @(t) rCenter + radius*[sin(2*pi*f*t),0,cos(2*pi*f*t)]';
drGoal = @(t) 2*pi*f*radius*[cos(2*pi*f*t),0,-sin(2*pi*f*t)]';

% define here the time resolution
deltaT = 0.01;
timeArr = 0:deltaT:1/f;

% q, r, and rGoal are stored for every point in time in the following arrays
qArr = zeros(3,length(timeArr));
rArr = zeros(3,length(timeArr));
rGoalArr = zeros(3,length(timeArr));

q = q0;
dq = dq0;
for i=1:length(timeArr)
    t = timeArr(i);
    % data logging, don't change this!
    q = q+deltaT*dq;
    qArr(:,i) = q;
    rArr(:,i) = r_BF_inB(q(1),q(2),q(3));
    rGoalArr(:,i) = rGoal(t);
    
    % controller: 
    % step 1: create a simple p controller to determine the desired foot
    % point velocity
    K = -10;
    v = drGoal(t) - K * (rGoal(t) - r_BF_inB(q(1),q(2),q(3)));
    % step 2: perform inverse differential kinematics to calculate the
    % generalized velocities
    dq = pinv(J_BF_inB(q(1),q(2),q(3))) * v;
    
end
     
% plotting
plot(rArr(1, 1), rArr(3, 1), 'kx')
hold on
plot(rGoalArr(1, :), rGoalArr(3, :), 'r-')
plot(rArr(1, :), rArr(3, :), 'b-')
hold off
xlabel('x')
ylabel('z')
legend('start', 'rGoal', 'r')
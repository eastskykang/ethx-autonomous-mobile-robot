%%

% this is not a problem
% simulator of omni-directional robot (from course website)

%% Try changing the wheel speeds to see what motions the robot does.
numSeconds=10;
% The speed of the first wheel (rad/s)
phi1 = 1.0;
% The speed of the second wheel (rad/s)
phi2 = 1.0;
% The speed of the third wheel (rad/s)
phi3 = 1.0;  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%% Run and plot the simulation
% Wheel 1, the far right wheel
alpha1=0.0;
beta1=0.0;
ell1=0.5;

% Wheel 2, the top left wheel
alpha2=(2/3)*pi;
beta2=0.0;
ell2=0.5;
      
% Wheel 3, the bottom left wheel
alpha3=(4/3)*pi;
beta3=0.0;
ell3=0.5;

% The wheel radius
r = 0.1;
    
% Build the wheel equations
J1 = [sin(alpha1+beta1), -cos(alpha1+beta1), -ell1*cos(beta1)];
J2 = [sin(alpha2+beta2), -cos(alpha2+beta2), -ell2*cos(beta2)];
J3 = [sin(alpha3+beta3), -cos(alpha3+beta3), -ell3*cos(beta3)];

% Build the stacked wheel equation
J = [J1;J2;J3];

% The wheel radius
r = 0.1;

R = 0.1*eye(3);

% Solve for the forward differential kinematics matrix
F = (J'*J)\J'*R;
      
% Stack the wheel speeds
phi = [phi1;phi2;phi3];      
stepsPerSec=10;
steps = ceil(stepsPerSec*numSeconds);
dt = 1.0/stepsPerSec;

xi = [0;0;0];

p0 = [0;0];
p1 = [0.1;0];
p2 = [0;0.1];

figure(1);
clf;
hold on;

values = zeros(4,steps);      

pxi = [];
t = 0;
% This loop performs simple Euler integration of
% the differential forward kinematics and plots 
% a coordinate frame of the robot every 1 second.
% The red line is the robot X axis and the green line
% is the robot Y axis. The robot starts at the origin
% with an orientation of zero.
for i = 1:steps
  values(1:3,i) = xi;
  values(4,i) = t;
  R = [ cos(xi(3)), sin(xi(3));
       -sin(xi(3)), cos(xi(3)) ];
  if mod(i,stepsPerSec) == 1
    % plot the current location
    Tp0 = xi(1:2);
    Tp1 = R'*p1 + xi(1:2);
    Tp2 = R'*p2 + xi(1:2);
    plot([Tp0(1),Tp1(1)], [Tp0(2),Tp1(2)],'r-','linewidth',2);
    plot([Tp0(1),Tp2(1)], [Tp0(2),Tp2(2)],'b-','linewidth',2);
  end
  if ~isempty(pxi)
      plot([pxi(1), xi(1)],[pxi(2),xi(2)], 'k-', 'linewidth',1);
  end
  
  % store the old xi
  pxi = xi;
  RR = [R, [0;0];
        [0,0,1]];
  % Propagate xi forward in time
  xi = pxi + RR' * F * phi * dt;
  t = t + dt;
end
hold on;
grid on;
axis equal;
X = max(abs(xlim));
Y = max(abs(ylim));
xlim([-X,X]);
ylim([-Y,Y]);
xlabel('x (m)')
ylabel('y (m)')

      
figure(2);
subplot(311)
plot(values(4,:),values(1,:));
xlabel('time (s)');
ylabel('x (m)');
ylim([-X,X])
subplot(312)
plot(values(4,:),values(2,:));
xlabel('time (s)');
ylabel('y (m)');
ylim([-Y,Y])
subplot(313)
plot(values(4,:), values(3,:));
xlabel('time (s)');
ylabel('theta (radians)');
ylim([-pi,pi])
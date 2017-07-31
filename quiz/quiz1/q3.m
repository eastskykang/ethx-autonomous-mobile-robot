%%
J = @(gamma) [ 1,                   0,                  0;                      % This line should hold the J submatrix for wheel 1
               sin(gamma + pi/2),   -cos(gamma + pi/2), -cos(gamma + pi/2)];    % This line should hold the J submatrix for wheel 2
              
C = @(gamma) [ 0,                   1,                  0;                      % This line should hold the C submatrix for wheel 1
               cos(gamma + pi/2),   sin(gamma + pi/2),  sin(gamma + pi/2)];     % This line should hold the C submatrix for wheel 2           

% A is the matrix of stacked wheel constraints        
A = @(gamma) [J(gamma);
              C(gamma)];

% B is the matrix with wheel radii padded with zeros for the no-sliding
% constraints
B = [0.3 * eye(2);
     zeros(2)];
             
% Given gamma, solve for the forward differential kinematics matrix      
F = @(gamma) A(gamma) \ B;
    
% Given gamma, solve for the inverse differential kinematics matrix
R = @(gamma) B \ A(gamma);

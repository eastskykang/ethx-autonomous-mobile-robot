%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 1: paste values for alpha, beta, and ell from   %
%         the answer to the last question              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wheel 1, the far right wheel
alpha1= 0;
beta1= 0;
ell1= 1/2;

% Wheel 2, the top left wheel
alpha2= 2/3 * pi();
beta2= 0;
ell2= 1/2;
      
% Wheel 3, the bottom left wheel
alpha3= 4/3 * pi();
beta3= 0;
ell3= 1/2;
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 2: derive the matrices J and R                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ith J =
% [sin(alpha_i + beta_i), -cos(alpha_i + beta_i), -l cos(beta_i)]
Ji = @(alpha, beta, l) ...
    [sin(alpha + beta), -cos(alpha + beta), -l * cos(beta)];

% stack Ji = [J1; J2; J3]
J = [...
    Ji(alpha1, beta1, ell1);
    Ji(alpha2, beta2, ell2);
    Ji(alpha3, beta3, ell3)];

% R is constant
R = 0.1 * eye(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step 3: Compute the forward differential             %
%         kinematics matrix, F                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Note: no lateral constraint (free rotate of small rollwers -> no constraint)

% J * xi_inR = R * phi
% xi_inR = pinv(J) * R * phi

% pinv(A) is pseudo-inverse of A 
%
% left p-inv    = inv(A'A) * A'     (when A is full column rank)
% right p-inv   = A' * inv(AA')     (when A is full row rank)

F = pinv(J) * R;
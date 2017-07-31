syms alpha beta x real

% rotational matrices calculated in previous problem set
R_W1 = [cos(alpha),-sin(alpha),0;sin(alpha),cos(alpha),0;0,0,1];
R_12 = [cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];

% write down the 3x1 relative position vectors for link length l_i=1
r_WA_inW = [0, 0, 0]';
r_AB_in1 = [0, 0, 1]';
r_BC_in2 = [1 + x, 0, 0]';

% write down the homogeneous transformation matrices
H_W1 = [...
    R_W1,       r_WA_inW;
    0, 0, 0,    1];
H_12 = [...
    R_12,       r_AB_in1;
    0, 0, 0,    1];
H_23 = [...
    eye(3),     r_BC_in2;
    0, 0, 0,    1];

% create the cumulative transformation matrix
H_W3 = H_W1 * H_12 * H_23; 

% find the foot point position vector
r_WC_inW = H_W3 * [0, 0, 0, 1]';
r_WC_inW = r_WC_inW(1:3);     

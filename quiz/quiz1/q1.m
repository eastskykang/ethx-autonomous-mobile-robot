syms alpha beta x real

% write down the rotation matrices using the symbolic parameters alpha, beta, x
R_W1 = [...
    cos(alpha),     -sin(alpha),    0;
    sin(alpha),     cos(alpha),     0;
    0,              0,              1];
R_12 = [...
    cos(beta),      0,              sin(beta);
    0,              1,              0;
    -sin(beta),     0,              cos(beta)];
     
      
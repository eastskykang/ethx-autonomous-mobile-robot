function [ LeftWheelVelocity, RightWheelVelocity ] = calculateWheelSpeeds( vu, omega, parameters )
%CALCULATEWHEELSPEEDS This function computes the motor velocities for a differential driven robot

wheelRadius = parameters.wheelRadius;
halfWheelbase = parameters.interWheelDistance/2;

%STARTRM
M = [wheelRadius/2                wheelRadius/2;
     wheelRadius/2/halfWheelbase -wheelRadius/2/halfWheelbase];
Minv = inv(M);
PhiPrime = Minv * [vu; omega];
LeftWheelVelocity = PhiPrime(2);
RightWheelVelocity = PhiPrime(1);
%ENDRM
%STARTUNCOMMENT
%LeftWheelVelocity = TODO;
%RightWheelVelocity = TODO;
%ENDUNCOMMENT
end

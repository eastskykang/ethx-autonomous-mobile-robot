function [ LeftWheelVelocity, RightWheelVelocity ] = calculateWheelSpeeds( vu, omega, parameters )
%CALCULATEWHEELSPEEDS This function computes the motor velocities for a differential driven robot

wheelRadius = parameters.wheelRadius;
halfWheelbase = parameters.interWheelDistance/2;

% [v; w] = [r/2 r/2; r/2l -r/2l] * [dphi_r; dphi_l]

R = [...
    1/2,                    1/2;
    1/(2 * halfWheelbase),  -1/(2 * halfWheelbase)] * wheelRadius;

dphi = R \ [vu; omega];

LeftWheelVelocity = dphi(2);
RightWheelVelocity = dphi(1);
end

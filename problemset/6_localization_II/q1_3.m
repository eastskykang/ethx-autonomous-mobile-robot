rand('seed', 1); % important for technical reasons
U = [ 1 -1 3 4 ]; % an artificial input sequence
% applyPredictionUpdate returns the predicted state:
applyPredictionUpdate = @(bel, u_t) [bel '.PU(' num2str(u_t) ')'];
% readSensor returns the current sensor's reading:
readSensor = @() [ 'Z(' num2str(round(20*rand())) ')' ]; 
% applyMeasurementUpdate returns the state updated by the measurements:
applyMeasurementUpdate = @(sensorReading, belBar) [ belBar '.MU(' sensorReading ')' ];
bel = 'PRIOR'; 
%%%%%%%%%%% PLEASE DON'T CHANGE ANYTHING ABOVE THIS LINE %%%%%%%%%%%
for u_t = U
    belBar = applyPredictionUpdate(bel, u_t);
    bel = applyMeasurementUpdate(readSensor(), belBar);
end

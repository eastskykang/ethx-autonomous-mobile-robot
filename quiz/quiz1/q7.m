 %% Generate the 'image' (as shown above) to work on
f=zeros(128,128); f(32:96,32:96)=255; 
[image, t3]=edge(f, 'canny', [0.04 0.10], 1);
          
%% set up variables for hough transform
theta_sample_frequency = 0.01;                                             
[rows, cols] = size(image);
rho_limit    = norm([rows cols]);                                                
rho   = -rho_limit:1:rho_limit;
theta = 0:theta_sample_frequency:pi;
num_thetas = numel(theta);
num_rhos   = numel(rho);
        
%% Initialize the voting array with the appropriate size and values        
Hough_space = zeros(num_rhos, num_thetas); 

%% perform hough transform
for x = 1:rows
    for y = 1:cols
        if image(x, y) == 1 %i.e. pixel (x,y) belongs to an edge
            for theta_index = 1:num_thetas
                th = theta(theta_index);
                r  = x * cos(th) + y * sin(th);
                rho_index = round(r + num_rhos/2);                 
        
        		%% Update the relevant element of Hough_space
                Hough_space(rho_index, theta_index) = ...
                    Hough_space(rho_index, theta_index) + 1;
            end
        end
    end
end
%% detect 4 peaks in Hough_space, corresponding to one set of parameters for each line we are looking for
P  = houghpeaks(Hough_space,4);
disp('The most voted-for (rho,theta) pairs: ');
for i=1:size(P,1)
	X = sprintf('(%.2f,%.2f)', rho(P(i,1)),theta(P(i,2)));
	disp(X)
end
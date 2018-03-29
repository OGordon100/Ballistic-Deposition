clear all
close all
%% READING

% Set conditions to be read in
x = 28;
N = 50000;
rep = 2;
stick = 60;

while stick < 101;
% Open appropriate directory
oldfolder = pwd;
cd(['x=',num2str(x),' stick=',num2str(stick)]);
disp(num2str(stick));

% Preallocate arrays for data to be stored in
all_width = zeros(rep,N);
all_meanheight = zeros(rep,N);
all_meanactiveheight = zeros(rep,N);
all_density = zeros(rep,N);

    % Read in files and store in array
    for N_loop = 1:rep
        filename = ['Rep = ',num2str(N_loop),'.txt'];
        all_data = dlmread(filename)';
        all_width(N_loop,:) = all_data(1:N);
        all_meanheight(N_loop,:) = all_data(N+1:(2*N));
        all_meanactiveheight(N_loop,:) = all_data(((2*N)+1):(3*N));
        all_density(N_loop,:) = all_data(((3*N)+1):end);
    end
    stick = stick+20;

%% AVERAGING

% Take average of each column
width_mean = mean((all_width));
height_mean = mean((all_meanheight));
activeheight_mean = mean((all_meanactiveheight));
density_mean = mean((all_density));

% Save averaged data
dlmwrite([num2str(rep),' Rep Average.txt'],...
    [width_mean;height_mean;activeheight_mean;density_mean])

%% PLOTTING
N_plot = 1:N;
width_plot = width_mean(N_plot);
height_plot = height_mean(N_plot);
activeheight_plot = activeheight_mean(N_plot);
density_plot = density_mean(N_plot);

hold on
loglog(height_plot,width_plot)

% Return to old directory
cd(oldfolder);
end
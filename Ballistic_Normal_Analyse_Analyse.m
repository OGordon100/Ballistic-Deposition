% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all
%% READING

% Set conditions to be read in
all_x = [8,16,32,64,128,256];
all_N = [10000,15000,25000,50000,200000,500000];
all_rep = [5000,5000,2500,1500,500,200];

% Read in and plot all data (for loop in reverse to make legend reverse)
for loop = 6:-1:1
    % Pick out conditions to read in
    x = all_x(loop);
    N = all_N(loop);
    rep = all_rep(loop);
    
    % Open appropriate directory
    oldfolder = pwd;
    cd(['x=',num2str(x),' N=',num2str(N)]);
    
    % Read in analysed file
    filename = [num2str(rep),' Rep Average','.txt'];
    all_data = dlmread(filename)';
    all_width = all_data(1:N);
    all_meanheight = all_data(N+1:(2*N));
    all_meanactiveheight = all_data(((2*N)+1):(3*N));
    all_density = all_data(((3*N)+1):end);
    
    % Return to original directory
    cd(oldfolder);
    
    %% PLOTTING
    
    % Set section to plot
    N_plot = 1:N;
    width_plot = (all_width(N_plot));
    height_plot = (all_meanheight(N_plot));
    activeheight_plot = (all_meanactiveheight(N_plot));
    density_plot = (all_density(N_plot));
    
    % Plot
    hold on
    plot(height_plot,width_plot)
    
end

% Set axis, legend, etc
set(gca,'XScale','log');
set(gca,'YScale','log');
legend(cellstr(num2str(all_x', 'l=%-d')),'Location','best')
xlabel('x axis','Interpreter','LaTex');
ylabel('y axis','Interpreter','LaTex');


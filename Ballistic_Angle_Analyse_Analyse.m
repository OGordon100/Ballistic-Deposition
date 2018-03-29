clear all
close all

%% READING

% Set conditions to be read in
all_angle = [20,30,40,50];
legend_x = fliplr(all_angle);
all_N = [150000,150000,150000,150000,150000];
all_rep = [500,500,500,500,500];

% Read in and plot all data (for loop in reverse to make legend reverse)
for loop = length(all_angle):-1:1 
    % Open appropriate directory
    x = 128;
    N = all_N(loop);
    rep = all_rep(loop);
    angle = all_angle(loop);

    oldfolder = pwd;
    cd(['x=',num2str(x),' angle=',num2str(angle)]);
    
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
    width_plot = log(all_width(N_plot));
    height_plot = log(all_meanheight(N_plot));
    activeheight_plot = log(all_meanactiveheight(N_plot));
    density_plot = log(all_density(N_plot));
    
    % Plot
    hold on
    plot(height_plot,smooth(width_plot,'sgolay'))
    
end

% Set axis (this is required because hold on overwrites loglog), legend,
% etc
%set(gca,'XScale','log');
%set(gca,'YScale','log');
legend(cellstr(num2str(legend_x', 'P(Stick) = %-d')),'Location','best')
xlabel('Height of Active Zone, $\bar{h}$','Interpreter','LaTex');
ylabel('Density of Active Zone, $\rho$','Interpreter','LaTex');


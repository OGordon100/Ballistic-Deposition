clear all
close all

%% READING

% Set conditions to be read in
all_stick = [20,40,60,80,100];
x = 64;
all_N = 4*[25000,25000,25000,25000,25000];
all_rep = [1000,1000,1000,1000,1000];

% Read in and plot all data (for loop in reverse to make legend reverse)
for loop = 5:-1:1 %length(all_stick):-1:1 
    
   
    N = all_N(loop);
    rep = all_rep(loop);
    stick = all_stick(loop);
    
    % Open appropriate directory
    oldfolder = pwd;
    cd(['x=',num2str(x),' stick=',num2str(stick)]);
    
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
legend_x = fliplr(all_stick);
legend(cellstr(num2str(legend_x', 'P(Stick) = %-d')),'Location','best')
xlabel('Mean Height of Active Zone, $\bar{h}$','Interpreter','LaTex');
ylabel('Width of Active Zone, $\xi$','Interpreter','LaTex');


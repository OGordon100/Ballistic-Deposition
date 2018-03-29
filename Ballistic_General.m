% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all
%% FIGURE SETUP
FigHandle1 = figure(1);
FigHandle1.Position = [100, 100, 1200, 600];
FigHandle1.Name='Main Window';
FigHandle1.NumberTitle='off';

%% VARIABLE SETUP

% Initialise variables
lat_x = 130;            % -2 for buffer zone around matrix
lat_y = 400;            % Must be at least extensionthresh
extensionthresh = 100;
Nblockmax = 100000;     % Number of blocks to deposit
repeats = 1;            % Number of repeats to run
stickyness = 100;       % Percentage probability of sticking
heightdif = 4;          % -1, Height difference

stick = 1;
varianceheights = zeros(Nblockmax,lat_x-2);
activefinder = zeros(1,3);
latticeextender = zeros(extensionthresh,lat_x);

% Set colormap
map = [0,0,0;1,0,0;1,1,0;];
colormap(map);

% Create appropriate directory to store data
oldfolder = pwd;
mkdir(['x=',num2str(lat_x-2),' N=',num2str(Nblockmax)]);
cd(['x=',num2str(lat_x-2),' N=',num2str(Nblockmax)]);

for rep = 1:repeats
    
    % Create/reset base 2D lattice
    lattice = zeros(lat_y,lat_x);
    lattice(end,1:lat_x) = 1;
    activelattice = zeros(lat_y,lat_x);
    activelattice(end,2:lat_x-1) = 2;
    
    % Create/reset working variables
    density = NaN(1,Nblockmax);
    maxheight = ones(1,lat_x);
    activeheight = 2.*maxheight;
    meanactiveheight = zeros(1,Nblockmax);
    finder = [2, lat_y, 2];
    
    dropx_all = round(2 + (lat_x-3).*rand(Nblockmax,1));
  %stick_all = rand(Nblockmax,1)<(stickyness/100);
 
    for N = 1:Nblockmax
        %% DROPPING
        
        % Pick a point to drop from
       %dropx=input('Drop Point: ');  % For manual dropping to test
        dropx = dropx_all(N);
       %stick = stick_all(N);
        
        % Detect highest sites in lattice area next to drop site
        heightrange = (finder(2)-2):(finder(2));
        [~,finder] = max(lattice(:,dropx-1:dropx+1));
        
       %latticeworker = lattice(:,dropx-1:dropx+blockw);
        if finder(1) < min(finder(2:end))
            %&& stick==1 ...
            %&& max(latticeworker(finder(1)+lat_y:finder(1)...
            %+lat_y+heightdif))==1
        % Stick to block on right
            lattice(finder(1),dropx) = 1;
            finder(2) = finder(1);
        elseif finder(end) < min(finder(1:end-1))
            %&& stick==1 ...
            %&& max(latticeworker(finder(3)+lat_y:finder(3)...
            %+lat_y+heightdif))==1
        % Stick to block on left
            lattice(finder(3),dropx) = 1;
            finder(2) = finder(3);
        elseif finder(1) == finder(3) && finder(1) < finder(2)
            %&& stick==1 ...
            %&& max(latticeworker(finder(1)+lat_y:finder(1)...
            %+lat_y+heightdif))==1
        % Stick to both right and left
            lattice(finder(1),dropx) = 1;
            finder(2) = finder(1);
        else
        % Lattice block exists below falling column
            lattice(finder(2)-1,dropx) = 1;
            finder(2) = finder(2)-1;
        end
        
        %% CALCULATE HEIGHTS
        
        % Calculate height of active zones
        [~,activefinder] = max(activelattice(heightrange,dropx-1:dropx+1)); 
        
        % Create new active zones u,r,l of plotted point if tallest
        activeheight(dropx-1:dropx+1) = lat_y-activefinder+1;
        maxheight(dropx-1:dropx+1) = lat_y-finder+1;
        activeheight(dropx-1:dropx+1) = lat_y-finder(2)+1;
        activeheight(dropx-1:dropx+1) = ...
            activeheight(dropx-1:dropx+1) + ...
            (activeheight(dropx-1:dropx+1)==maxheight(dropx-1:dropx+1));
        
        if dropx == 2 || dropx == lat_x-1
            % Wrap lattice
            heightrange2 = (finder(2)-5):(finder(2)+1);
            latticetrans = lattice(heightrange2,end-1);
            lattice(heightrange2,end) = lattice(heightrange2,2);
            lattice(heightrange2,1) = latticetrans;
            
            % Wrap active zone
            activeretrans = activeheight(end);
            activeheight(end-1) = activeheight(1);
            activeheight(2) = activeretrans;
            activelattice(lat_y-activeheight(end-1)+1,end-1) = 2;
        end
        
        % Add new active zones to active zone lattice
        activeheight(dropx) = lat_y-finder(2)+2;
        activelattice(lat_y-activeheight(dropx-1)+1,dropx-1) = 2;
        activelattice(lat_y-activeheight(dropx)+1,dropx) = 2;
        activelattice(lat_y-activeheight(dropx+1)+1,dropx+1) = 2;
        activelattice(lat_y-activeheight(2)+1,2) = 2;
        
        % Make lattice taller if blocks approaching lattice height
        maxmaxheight = max(maxheight);
        if maxmaxheight  == lat_y-extensionthresh
            lattice = [latticeextender;lattice];
            activelattice = [latticeextender;activelattice];
            lat_y = lat_y+extensionthresh;
        else
        end
        
        %% DENSITY
        % Divide number of plotted points by full square of tallest tower
        % height
        maxarea = (maxmaxheight-1)*(lat_x-2);
        density(N) = N/maxarea;
        
        %% AVERAGE ACTIVE HEIGHT
        meanactiveheight(N) = sum(maxheight(2:end-1))/(lat_x-2);
        
        %% CALCULATE WIDTH OF ACTIVE ZONE
        % Store heights for each run
        varianceheights(N,:) = activeheight(2:end-1);
    end
    % Calculate std for all runs
    meanheight = mean(varianceheights,2);
    variancesum = sum((varianceheights - repmat(meanheight,1,lat_x-2)).^2,2);
    W = sqrt(variancesum/(lat_x-2));
    %% PLOTTING
    
    % Plot blocks
    subplot(2,2,[1,3])
    image(lattice(:,2:end-1)+1)
   %image(activelattice(:,2:end-1)+1)
    axis equal
    
   % Plot width of active site
    subplot(2,4,4)
    loglog(1:Nblockmax,W)
    xlim([0 Nblockmax])
    xlabel('Number of Particles Deposited')
    ylabel('Width of Active Site, \xi')
    
    % Plot density
    subplot(2,4,8)
    plot(1:Nblockmax,density)
    xlabel('Number of Particles Deposited')
    ylabel('Density, \rho')
    
    % Watch in realtime - uncomment these lines & comment out line 146
   %drawnow               % Uncomment to view all graphs/plot in realtime
   %map = [0,0,0;1,0,0;1,1,0;];
   %colormap(map);
   %end                   % Uncomment+comment line 146 to watch in realtime
    %% SAVING
    % Save full output
    dlmwrite(['Rep ',num2str(rep),'.txt'],...
        [W';meanheight';meanactiveheight;density])
    
end

% Return to old directory
cd(oldfolder);
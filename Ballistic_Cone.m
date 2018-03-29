% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all
%% FIGURE SETUP
newfig = figure(1);
newfig.Position = [100, 100, 1200, 600];
newfig.Name='Main Window';
newfig.NumberTitle='off';

%% VARIABLE SETUP

% Initialise variables
lat_x = 500;            % -2 for buffer zone around matrix
lat_y = 800;            % Must be at least extensionthresh
extensionthresh = 100;
Nblockmax = 100000;     % Number of blocks to deposit
repeats = 1;            % Number of repeats to run
stickyness = 100;       % Percentage probability of sticking
heightdif = 4;          % -1, Height difference

latticeextender = zeros(extensionthresh,lat_x,'int8');

% Set colormap
set(0,'DefaultFigureColormap',[0,0,0;1,0,0;1,1,0;])

for rep = 1:repeats
    
    % Create/reset base 2D lattice
    lattice = zeros(lat_y,lat_x,'int8');
    lattice(end,[100,250,400]) = 1;         % Set points to seed from

    maxheight = ones(1,lat_x);
    finder = [lat_y, lat_y-1, lat_y];
    
    dropx_all = round(2 + (lat_x-3).*rand(Nblockmax,1));
   %stick_all = rand(Nblockmax,1);
    
    for N = 1:Nblockmax
        %% DROPPING
        % Pick a point to drop from
        %dropx=input('Drop Point:');  % For manual dropping to test
        dropx = dropx_all(N);
        
        % Detect highest sites in lattice area next to drop site
        heightrange = (finder(2)-2):(finder(2));
        [~,finder] = max(lattice(:,dropx-1:dropx+1));
        finder(finder==1) = lat_y;
        
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
        elseif max(lattice(:,dropx)) == 0
            % No block below so do nothing
        else
        % Lattice block exists below falling column
            lattice(finder(2)-1,dropx) = 1;
            finder(2) = finder(2)-1;
        end
        
        % Make lattice taller if blocks approaching lattice height
        maxmaxheight = max(maxheight);
        if maxmaxheight  == lat_y-extensionthresh
            lattice = [latticeextender;lattice];
            activelattice = [latticeextender;activelattice];
            lat_y = lat_y+extensionthresh;
        else
        end
        
    end
    %% PLOTTING
    
    % Plot blocks
    newfig = figure(rep);
    newfig.Name=['Ballistic Cone, Rep ' num2str(rep)];
    newfig.Position = [100, 100, 1200, 600];
    
    image(lattice(:,2:end-1))
    %image(activelattice(:,2:end-1))
    axis equal
end
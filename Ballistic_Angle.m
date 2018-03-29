% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all
%% FIGURE SETUP
FigHandle1 = figure(1);
FigHandle1.Position = [100, 100, 1200, 600];
FigHandle1.Name='Ballistic_Angle';
FigHandle1.NumberTitle='off';

%% VARIABLE SETUP

% Initialise variables

% Initialise variables
lat_x = 512;            % -2 for buffer zone around matrix
lat_y = 1500;            % Must be at least extensionthresh
extensionthresh = 750;
Nblockmax = 50000;     % Number of blocks to deposit
repeats = 1;            % Number of repeats to run
stickyness = 100;       % Percentage probability of sticking
heightdif = 4;          % -1, Height difference
angle = 45;             % Angle to drop from
%rng(1)

varianceheights = zeros(Nblockmax,lat_x-2);
latticeextender = zeros(extensionthresh,lat_x);

% Set colormap
map = [0,0,0;1,0,0;1,1,0;];
colormap(map);

for rep = 1:repeats
    
    % Create/reset base 2D lattice
    lattice = zeros(lat_y,lat_x);
    
    maxheight = ones(1,lat_x);
    activeheight = 2.*maxheight;
    activemean = zeros(1,Nblockmax);
    meanactiveheight = zeros(1,Nblockmax);
    finder = [2, lat_y, 2];
    
    % Rotate starting matrix
    totlength = 1:lat_x;
    newheight = lat_y-round(tand(angle)*totlength);
    yshift = lat_y-newheight;
    lattice(sub2ind(size(lattice),newheight,totlength))=1;
    activelattice(sub2ind(size(lattice),newheight,totlength))=2;
    
    % Pick points to drop from
    dropx_all = round(2 + (lat_x-3).*rand(Nblockmax,1));
    
    for N = 1:Nblockmax
        %% DROPPING
        % Pick a point to drop from
       %dropx=input('Drop Point: ');  % For manual dropping to test
        dropx = dropx_all(N);
        
        % Detect highest sites in latticeworker
        heightrange = (finder(2)-5):(finder(2));
        heightrangesmall = (finder(2)-3):(finder(2));
        [~,finder] = max(lattice(:,dropx-1:dropx+1));
        
        if finder(1) < min(finder(2:end))
        % Stick to block on right
            lattice(finder(1),dropx) = 1;
            finder(2) = finder(1);
        elseif finder(end) < min(finder(1:end-1))
        % Stick to block on left
            lattice(finder(3),dropx) = 1;
            finder(2) = finder(3);
        elseif finder(1) == finder(3) && finder(1) < finder(2)
        % Stick to both right and left
            lattice(finder(1),dropx) = 1;
            finder(2) = finder(1);
        else
        % Lattice block exists below falling column
            lattice(finder(2)-1,dropx) = 1;
            finder(2) = finder(2)-1;
        end
        
        %% CALCULATE HEIGHTS
        
            % Wrap lattice
            latticeretrans = lattice(heightrangesmall,end-1);
            lattice(heightrangesmall+(yshift(end))-3,1) = latticeretrans;
            %try    %%% - Wierd MATLAB bug. 
                    %%% - Can either pause or try, but try is faster               
                lattice(heightrangesmall-(yshift(end))+3,end)...
                    = lattice(heightrangesmall,2);
            %catch
            %    break
            %end

        % Make lattice taller if blocks approaching lattice height
        maxmaxheight = max(maxheight);
        if maxmaxheight  == lat_y-(1000)
            lattice = [latticeextender;lattice];
            activelattice = [latticeextender;activelattice];
            lat_y = lat_y+extensionthresh;
        else
        end
   end     
        %% PLOTTING
        
        % Plot blocks
        image(lattice(:,2:end-1)+1)
        axis equal
        
    % Watch in realtime - uncomment these lines & comment out line 107
   %drawnow               % Uncomment to view all graphs/plot in realtime
   %map = [0,0,0;1,0,0;1,1,0;];
   %colormap(map);
   %end                   % Uncomment+comment line 107 to watch in realtime
    
end
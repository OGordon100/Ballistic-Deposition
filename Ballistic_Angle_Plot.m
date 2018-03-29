% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all

% Input calculated data
inc_angle = tand([20,25,30,35,40,45]);
width = [128,256,512];
growth_ang = tand([10.6,13.07,18.38,19.68,21.32,23.17;...
    8.76,12.34,15.57,17.22,20.24,23.56;...
    9.23,11.07,13.36,16.57,19.02,22.28]);
growth_error = tand([2,3,3,2,1,2;...
    2,4,3,2,2,3;...
    2,1,2,2,1,2]);

% Plot all together
for loop = 1:3
    hold on
    errorbar(inc_angle,(growth_ang(loop,:)), (growth_error(loop,:)),'x')
    growth_ang_fit = (growth_ang(loop,:));
    growth_error_fit = growth_error(loop,:);
end

legendstuff = {'l = 128','l = 256','l = 512'};
legend(legendstuff','Location','Best')
xlabel('Angle of Incidence, $tan(\theta_i)$','Interpreter','LaTeX')
ylabel('Angle of Growth, $tan(\theta_g)$','Interpreter','LaTeX')

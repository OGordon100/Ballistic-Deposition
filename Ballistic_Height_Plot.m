% Oliver Gordon, 4224942
% Ballistic Project
clear all
close all

% Input calculated data
Height = [25,28,30,33,35,38,40,43,45];
width = [32,64,128];
drop = [100,96,80,68,52,32,20,8,4;...
    96,92,64,36,28,16,12,4,0;...
    68,60,40,32,28,16,12,4,0];
drop_error = [0,4,8,4,4,4,0,0,4;...
    8,4,4,4,4,0,0,8,4;...
    8,12,8,4,0,0,4,4,4];

% Plot 
for loop = 1:3
    hold on
    errorbar(Height,(drop(loop,:)),drop_error(loop,:),'x')
    drop_fit = (drop(loop,:));
    drop_error_fit = drop_error(loop,:);
end

% Set labels, legend, etc
legendstuff = {'l = 32','l = 64','l = 128'};
legend(legendstuff','Location','Best')
xlabel('Height Difference','Interpreter','LaTeX')
ylabel('Probability of Desaturating','Interpreter','LaTeX')
ylim([0 100]);
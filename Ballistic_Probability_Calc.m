clear all
close all

% Input calculated data
stick = [20,40,60,80,100];
width = [8,16,32,64,128];
ln_width = log(width);
legendstuff = {'P(Stick) = 20%','P(Stick) = 40%','P(Stick) = 60%','P(Stick) = 80%','P(Stick) = 100%'};

e0 = [4.534,5.918,7.254,9.154,11.724;...
    2.871,3.934,5.189,6.684,8.675;...
    2.128,3.114,4.186,5.456,7.265;...
    1.706,2.599,3.586,4.783,6.312;...
    1.368,2.152,3.004,4.168,5.725];
delta_e0 = [0.095,0.098,0.101,0.111,0.155;...
    0.071,0.082,0.086,0.092,0.105;...
    0.054,0.056,0.065,0.073,0.087;...
    0.022,0.025,0.042,0.053,0.067;...
    0.014,0.015,0.024,0.035,0.075];

% Plot all together
for loop = 1:5     
    hold on
    errorbar(ln_width,log(e0(loop,:)),delta_e0(loop,:),'x')
end

legend(legendstuff','Location','Best')
xlabel('$ln(l)$','Interpreter','LaTeX')
ylabel('$ln(\xi_0)$','Interpreter','LaTeX')
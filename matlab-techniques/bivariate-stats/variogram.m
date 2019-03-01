%problem 1
function variogram
addpath('C:\Users\Greg\Documents\GEOPHYS 112');
R = importdata('regressiondata.mat');
vrgdata = R.('vrgdata');
lag = vrgdata(:,1);
var = vrgdata(:,2);
a = 1;
c = 1;
[a1, c1] = fminsearch(@(lag) vario(a, c, lag, var),1);
for j=1:length(lag)
    if lag(j) < a1
        yPred(j) = c1*(1.5*(lag(j)/a1) - 0.5*(lag(j)/a1)^3);
    else
        yPred(j) = c1;
    end
end
figure;
plot(lag, var);
hold on
plot(lag, yPred);
title('fminsearch')
%optimization tool like optimtool
opts = optimoptions('fminunc'); 
opts = optimoptions('fminunc','algorithm','quasi-newton'); 
opts = optimoptions(opts, 'Display' ,'iter'); 
[aopt, copt] = fminunc(@(lag) vario(a, c, lag, var), 1, opts);
aopt
copt
%aopt = 5.7528
%copt = .9371
[a2, c2] = lsqnonlin(@(lag) vario(a, c, lag, var),0);
yNew = zeros([1 length(lag)]);
for j=1:length(lag)
    if lag(j) < a2
        yNew(j) = c2*(1.5*(lag(j)/a2) - 0.5*(lag(j)/a2)^3);
    else
        yNew(j) = c2;
    end
end
figure;
plot(lag, var)
hold on
plot(lag, yNew);
title('Lsqnonlinear')
end
function [yErr2] = vario(a, c, lag, var)
yPred = zeros([1 length(lag)]);
for i = 1:length(lag)  
    if lag(i) < a
        yPred(i) = c*(1.5*(lag(i)/a) - 0.5*(lag(i)/a)^3);
    else
        yPred(i) = c;
    end
end
yErr = (var-yPred);
yErr2 = sum(yErr.^2);
norm(yErr);
%norm of residuals (yErr) = .9681
end
    


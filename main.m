% Script to analyze load to failure and stress relaxation data and produce
% graphs. All force measurements are in Newtons nd all distance 
% measurements are in mm.

clear; clc; close all

%% Input
SR = 100; % Sampling rate of 100 Hz
N = 7; % Number of inputs into the Weichert model
Diameter = 2.5; % Diameter of the indenter tip in mm
Area = (Diameter/2)^2*pi; % Calculate indenter tip area

% Load Data
FailureData = readmatrix('Data/LoadToFailureRawData.xlsx');
RelaxationData = readmatrix('Data/StressRelaxationRawData.xlsx');

%% Stress Relaxation
SRDepth = 1.32; % Initial length for stress relaxation test in mm
[time,RelaxationModulus,timeRelax,weichertRel,SD,PE,tau,EValues,correlation] = stress_relaxation_analysis(SRDepth,Area,N,RelaxationData); % Run function to analyze stress relaxation data

% Plotting Stress Relaxation
figure(1)
plot(time,RelaxationModulus,'--k')
hold on
plot(timeRelax,weichertRel,'k')
title("Stress Relaxation")
xlabel("Time (s)")
ylabel("Relaxation Modulus (MPa)")
legend('Raw Data','Fitted Wiechert Model')
axis([0 120 0 4])

%% Load to Failure
LFDepth = 2.9; % Initial length for load to failure test in mm
[strain,stress,ultimate,x1,y1,x2,y2] = load_to_failure_analysis(FailureData,LFDepth,Area); % Run function to analyze load to failure data

% Plot load to failure
figure(2)
plot(strain,stress,'k')
title("Load to Failure")
xlabel("Strain")
ylabel("Stress (MPa)")
hold on
plot(x1,y1,'k*','MarkerSize',10) % Plot point of ultimate stress
plot(x2,y2,'rx','MarkerSize',10) % Plot point of failure
legend('Stress over Strain','Ultimate Stress','Failure','Location','northwest')
axis([0 1.8 0 14])

%% Output Equation
fileID = fopen('Output/equation.txt','wt');
fprintf(fileID,'The following is the equation for relaxation modulus in MPa as a function of time in seconds as calculated by the Weichert Model:\n\n');
fprintf(fileID,'E = %.2f',EValues(1)); % Initialize each equation with the first fitted constant
for i = 2:length(EValues')
    % Loop through the remaining constants
    fprintf(fileID,' + %.2f * exp(-t / %.2f)',EValues(i),tau(i)); % Add them to the equation
end
fclose(fileID);

%% Output Statistics
fileID = fopen('Output/statistics.txt','wt');
fprintf(fileID,'The following values are the statistical differences between the experimentally acquired stress relaxation values, and the expected values from the Weichert Model:\n\n');
fprintf(fileID,'%-20s = %.4f MPa\n','Standard Deviation',SD);
fprintf(fileID,'%-20s = %.4f%%\n','Percent Error', PE);
fprintf(fileID,'%-20s = %.4f\n','Correlation',correlation);
fclose(fileID);
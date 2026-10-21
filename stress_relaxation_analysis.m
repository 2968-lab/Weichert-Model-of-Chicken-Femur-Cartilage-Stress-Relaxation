% Function to analyze data from a stress relaxation test. Input the initial
% depth and area along with the number of desired terms in the Weichert 
% model and a matrix of the normalized data. Input data matrix with time in
% the first column, normalized force in the second column, and normalized 
% length in the third column. Outputs arrays for the time and relaxation 
% modulus of the raw data, as well as time and relaxation modulus produced 
% by the Weichert model, as well as the average standard deviation and 
% percent error between the two.

function [time,RelaxationModulus,timeRelax,weichertRel,SD,PE,tau,EValues,correlation] = stress_relaxation_analysis(SRDepth,Area,N,RelaxationData)

    time = RelaxationData(:,1,1); % Extract time array in seconds
    force = RelaxationData(:,2,1); % Force array in Newtons
    [~,maxIndex] = max(force); % finds where the maximum force occurs
    timeRelax = time(maxIndex:end); % Begins the time array with the maximum force
    strain = abs(RelaxationData(maxIndex,3,1)/SRDepth); % Calculates the strain that occurs when the maximum force is reached
    RelaxationModulus = force / Area / strain; % Calculates the relaxation modulus
    weichertRelaxation = RelaxationModulus(maxIndex:end); % Begins relaxation modulus array at the maximum force
    
    [weichertRel,tau,EValues] = calculate_weichert(timeRelax,weichertRelaxation,N); % Calculate the relaxation modulus through the Weichert model

    % Find the standard deviation of the curved fit data
    SD = std(weichertRel-weichertRelaxation);
    
    % Find the percent error
    PE = mean(abs(weichertRel-weichertRelaxation)./weichertRel) * 100;

    % Find the correlation between the model and experimental data
    correlation = corr(weichertRel,weichertRelaxation);

end
% Function to analyze data from a load to failure test. Inputs data matrix,
% intial displacement, and area. The data matrix needs to be formatted as
% two columns of normalized data, with the first column representing
% displacement and the second column representing force. Outputs the
% strain, stress, ultimate stress, coordiantes of ultimate stress, and
% coordinates of failure.

function [strain,stress,ultimate,x1,y1,x2,y2] = load_to_failure_analysis(FailureData,LFDepth,Area)

    force = FailureData(:,2,1); % Force array in Newtons
    length = FailureData(:,1,1); % Displacement array in mm
    strain = abs(length / LFDepth); % Calculates the strain
    stress = force / Area; % Calculates the stress
    [ultimate,index] = max(stress); % Saves the maximum stress
    x1 = strain(index); y1 = stress(index); % Saves the point of maximum stress
    [~,g] = sgolay(2,51); % Differentiation filter
    derivative = conv(stress, flip(g(:,2))); % Finds the first order derivative of the stress
    derivative = derivative(26:end-25); % Truncate off the elements added by the sgolay convolution
    [~,index] = min(derivative); % Finds the indices where the derivative is minimized
    x2 = strain(index); y2 = stress(index); % Saves the failure point (greatest negative decrease)

end
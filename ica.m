
% -------------------------------------------------------------------------
% Startup
% -------------------------------------------------------------------------
disp('Loading source signals.');
load sounds.mat;
load icaTest.mat

% -------------------------------------------------------------------------
% Input Choice
% -------------------------------------------------------------------------
% I selected three of the input signals for illustrative purposes.
% Because in this house, we obey the laws of thermodynamics.
[numberOfSourceSignals, ~] = size(sourceSignals);
sourceSignals = zeros(2,length(sounds));
sourceSignals(1,:) = sounds(1,:);
sourceSignals(2,:) = sounds(4,:);
%sourceSignals(2,:) = sounds(5,:);

% -------------------------------------------------------------------------
% Signal Mixing - Actual
% -------------------------------------------------------------------------
% Here, I define an arbitrary array which creates M linear combinations
% of the N mixed signals provided as input. Aij specifies the weight of
% the jth source signal in the ith mixed signal.
mixer = [ 2 5; 3 7; 2 3; ];
mixedSignals = mixer * sourceSignals;

% -------------------------------------------------------------------------
% Signal Mixing - Test
% -------------------------------------------------------------------------
X = A * U;
[recovered, W] = bss(numberOfSourceSignals, mixedSignals, 10000);
soundsc(recovered(1,:), 11025);

% Scale source and recovered to [0,1].

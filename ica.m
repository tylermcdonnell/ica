
% -------------------------------------------------------------------------
% Startup
% -------------------------------------------------------------------------
disp('Loading source signals.');
load sounds.mat;
load icaTest.mat

% -------------------------------------------------------------------------
% Experiment #1 - Comparison of Different Inputs
% -------------------------------------------------------------------------
% I selected three of the input signals for illustrative purposes.
% Because in this house, we obey the laws of thermodynamics.

L = length(sounds);


% First, we select two sets of input signals for this experiment.
sourceSignals1 = zeros(2,length(sounds));
sourceSignals1(1,:) = sounds(1,:);
sourceSignals1(2,:) = sounds(4,:);

sourceSignals2 = zeros(2,length(sounds));
sourceSignals2(1,:) = sounds(1,:);
sourceSignals2(2,:) = sounds(5,:);

[N, ~] = size(sourceSignals1);

% We now mix the signals using arbitrary linear combinations of originals.
mixer = [ 2 5; 3 7];
mixedSignals1 = mixer * sourceSignals1;
mixedSignals2 = mixer * sourceSignals2;

% Now, we attempt to recover the original signals using ICA.
[recovered1, ~] = bss(N, mixedSignals1, 10000, 0.001);
[recovered2, ~] = bss(N, mixedSignals2, 10000, 0.001);

% Uncomment to listen to recovered signals.
%soundsc(recovered1(1,:), 11025);
%soundsc(recovered1(2,:), 11025);
%soundsc(recovered2(1,:), 11025);
%soundsc(recovered2(2,:), 11025);

% Scale all signals.
recovered1(1,:) = scaletoone(recovered1(1,:));
recovered1(2,:) = scaletoone(recovered1(2,:));
recovered2(1,:) = scaletoone(recovered2(1,:));
recovered2(2,:) = scaletoone(recovered2(2,:));

mixedSignals1(1,:) = scaletoone(mixedSignals1(1,:));
mixedSignals1(2,:) = scaletoone(mixedSignals1(2,:));
mixedSignals2(1,:) = scaletoone(mixedSignals2(1,:));
mixedSignals2(2,:) = scaletoone(mixedSignals2(2,:));

sourceSignals1(1,:) = scaletoone(sourceSignals1(1,:));
sourceSignals1(2,:) = scaletoone(sourceSignals1(2,:));
sourceSignals2(1,:) = scaletoone(sourceSignals2(1,:));
sourceSignals2(2,:) = scaletoone(sourceSignals2(2,:));

% Figure 1 - Source Signals
figure()
subplot(1, 2, 1);
plot(1:L, sourceSignals1(1,:) + 1, 1:L, (sourceSignals1(2,:) + 3))
axis off
subplot(1, 2, 2);
plot(1:L, sourceSignals2(1,:) + 1, 1:L, (sourceSignals2(2,:) + 3))
xlabel('Source Signals')
axis off

% Figure 2 - Mixed Signals
figure()
subplot(1, 2, 1);
plot(1:L, mixedSignals1(1,:) + 1, 1:L, (mixedSignals1(2,:) + 3))
axis off
subplot(1, 2, 2);
plot(1:L, mixedSignals2(1,:) + 1, 1:L, (mixedSignals2(2,:) + 3))
xlabel('Source Signals')
axis off

% Figure 3 - Reconstructed Signals
figure()
subplot(1, 2, 1);
plot(1:L, recovered1(1,:) + 1, 1:L, (recovered1(2,:) + 3))
axis off
subplot(1, 2, 2);
plot(1:L, recovered2(1,:) + 1, 1:L, (recovered2(2,:) + 3))
xlabel('Source Signals')
axis off

subplot(1,3,1);
plot(1:L, sounds(1,:));
axis off
subplot(1,3,2);
plot(1:L, sounds(4,:));
axis off
subplot(1,3,3);
plot(1:L, sounds(5,:));
axis off

% -------------------------------------------------------------------------
% Experiment #2 - Gradient Descent Iterations
% -------------------------------------------------------------------------
% Here we display recovered signals for various numbers of iterations of
% gradient descent.

disp('Experiment 2: Gradient Descent Iterations. Press ENTER');
pause;

% For this experiment, let's just use two source signals and the previously
% constructed mixing matrix.
mixedSignals = mixer * sourceSignals1;

testIterations = [ 10 100 1000 10000 100000 ];

figure()
subplot(length(testIterations) + 1, 1, 1);
plot(1:L, sourceSignals1(1,:))
axis off
for i = 1:length(testIterations)
    % Compute.
    subplot(length(testIterations) + 1, 1, i + 1);
    [recovered1, ~] = bss(N, mixedSignals, testIterations(i), 0.001);
    
    % Scale.
    sourceSignals1(1,:) = scaletoone(sourceSignals1(1,:));
    sourceSignals1(2,:) = scaletoone(sourceSignals1(2,:));
    recovered1(1,:) = scaletoone(recovered1(1,:));
    recovered1(2,:) = scaletoone(recovered1(2,:));
    
    % Plot.
    % Note: There is not guarantee which order we recover the signals in,
    % so we do a sanity check.
    recoveredSignal = maptosource(sourceSignals1(1,:), recovered1);
    plot(1:L, recovered1(1,:));
    axis off
    (i)
    
end

% -------------------------------------------------------------------------
% Experiment #3 - Different Learning Rates
% -------------------------------------------------------------------------
disp('Experiment 3: Different Learning Rates. Press ENTER');
pause;

% For this experiment, let's just use two source signals and the previously
% constructed mixing matrix.
mixedSignals = mixer * sourceSignals1;

testRates = [ 0.001 0.0001 ];
figure()
subplot(length(testRates) + 1, 1, 1);
plot(1:L, sourceSignals1(1,:))
axis off
for i = 1:length(testRates)
    % Compute.
    subplot(length(testRates) + 1, 1, i + 1);
    [recovered1, ~] = bss(N, mixedSignals, 5000, testRates(i));
    
    % Scale.
    sourceSignals1(1,:) = scaletoone(sourceSignals1(1,:));
    sourceSignals1(2,:) = scaletoone(sourceSignals1(2,:));
    recovered1(1,:) = scaletoone(recovered1(1,:));
    recovered1(2,:) = scaletoone(recovered1(2,:));
    
    % Plot.
    % Note: There is not guarantee which order we recover the signals in,
    % so we do a sanity check.
    recoveredSignal = maptosource(sourceSignals1(1,:), recovered1);
    plot(1:L, recoveredSignal(1,:));
    axis off
    (i)   
end
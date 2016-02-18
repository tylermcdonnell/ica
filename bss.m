function [ recovered, W ] = bss( N, mixedSignals, i )
%BSS Summary of this function goes here
%   Detailed explanation goes here

[M, ~] = size(mixedSignals);

% Tunable learning rate for gradient descent.
learningRate = 0.0005;
W = rand(N, M) * 0.10;

for i = 1:i
    sourceEstimate = W * mixedSignals;
    Z = (1 + exp(-sourceEstimate)).^-1;
    deltaW = learningRate * (eye(N, N) + (1 - 2*Z)*sourceEstimate')*W;
    W = W + deltaW;
end

recovered = W * mixedSignals;

end


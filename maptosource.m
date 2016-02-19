function [ recoveredSource ] = maptosource( sourceSignal, recoveredSignals )
%maptosource Finds the recovered signal most similar to a source.
%   Since ICA can recover signals in arbitrary order with respect to the
%   order they were mixed, we use this simple MSE-based algorithm to map a
%   source signal to its recovered counterpart. 
%
%   Given an 1 x t source signal and an n x t matrix of recovered signals,
%   this returns the recovered signal which is most similar to the source.

[N, ~] = size(recoveredSignals);
MSE = zeros(N, 1);

for i = 1:N
    MSE(i) = immse(sourceSignal, recoveredSignals(i,:));
end

[~, I] = min(MSE);
I
recoveredSource = recoveredSignals(I, :);

end


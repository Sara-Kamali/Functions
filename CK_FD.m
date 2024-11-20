%This function computes the modified Katz fractal dimension, proposed by Castiglioni, we
%call it CKFD. (DOI: https://doi.org/10.1016/j.compbiomed.2010.10.001)
% The input, y, is a one dimensional time-series vector.

function CKFD= CK_FD(y)

N = length(y);

%Computing the difference between the max and min of the vector
max_dist = abs(max(y)- min(y));

% Find the size of sliding window
N_win= max(max_dist,8);
% Size of overlap between windows, set to 20%
N_ovrlap = ceil(N_win * .2);

j=0;CKFD_win=[];
% Slide the window
for i=1:N_win-N_ovrlap:N-N_win
    yw=y(i:i+N_win);
    % Sum the absolute difference between consecutive poits
    eu_length = sum(abs(diff(yw)));
    max_dist_yw= abs(max(yw)-min(yw));
    % Compute CKFD of the current window
    j=j+1;
    CKFD_win(j) = log10(N_win)/(log10(N_win) + log10(max_dist_yw/eu_length));
end

CKFD= mean(CKFD_win);


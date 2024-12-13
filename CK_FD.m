%This function computes the modified Katz fractal dimension, proposed by Castiglioni, we
%call it CKFD. (DOI: https://doi.org/10.1016/j.compbiomed.2010.10.001)
% The input, y, is a one dimensional time-series vector.

function CKFD= CK_FD(y)


%Computing the difference between the max and min of the vector
max_dist = abs(max(y)- min(y)); 

% Find the size of sliding window
% Initialize variables
N = length(y);
window_length = N; % Start with the full length, then reduce

% Iterate over possible window lengths
for w = 8:floor(N/2)
    dist_yw=zeros(1,N-w);
    % Slide the window across the signal
    for i = 1:(N - w + 1)
        yw = y(i:i+w-1); % Current window
        dist_yw(i) = abs(max(yw) - min(yw));
    end
    if (max(dist_yw)) >= max_dist/2
        % If condition is met stop searching
        break
    end
end
window_length = w;



% Size of overlap between windows, set to 20%
N_ovrlap = ceil(window_length * .2);

j=0;CKFD_win=[];
% Slide the window
for i=1:window_length-N_ovrlap:N-window_length
    yw=y(i:i+window_length);
    % Sum the absolute difference between consecutive poits
    eu_length = sum(abs(diff(yw)));

    max_dist_yw= abs(max(yw)-min(yw));
    % Compute CKFD of the current window
    j=j+1;
    CKFD_win(j) = log10(window_length)/(log10(window_length) + log10(max_dist_yw/eu_length)); 
end

CKFD= mean(CKFD_win);






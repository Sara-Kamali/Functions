%  Compute the Petrosian Fractal Dimension (PFD) of a 1-D signal.
function pfd = petrosian_fractal_dimension(signal)
    % Ensure the input is a row vector
    signal = signal(:)';

    % Compute the number of sign changes in the signal's first difference
    diff_signal = diff(signal); % First-order difference
    % Count zero-crossings 
    sign_changes =  sum(diff(diff_signal > 0) ~= 0)-1;

    % Total number of points in the signal
    N = length(signal);

    % Compute the Petrosian Fractal Dimension
    pfd = log10(N) / (log10(N) + log10(N / (N + 0.4 * sign_changes)));
end



% function HFD = Higuchi_FD(timeSeries, kMax)
%     % This function calculates Higuchi's Fractal Dimension (HFD) of a given time series.
%     % Inputs:
%     %   timeSeries - The input time series data (vector)
%     %   kMax - The maximum number of k values to use
%     % Output:
%     %   HFD - The calculated Higuchi's Fractal Dimension
% 
%     % Ensure the time series is a row vector
%     timeSeries = timeSeries(:)';
% 
%     % Length of the time series
%     N = length(timeSeries);
% 
%     % Initialize the L(k) vector
%     Lk = zeros(1, kMax);
% 
%     % Loop over different k values
%     for k = 1:kMax
%         Lm = zeros(1, k);
%         for m = 1:k
%             % Compute the length of curve for each m and k
%             lengthSum = 0;
%             for i = 1:floor((N - m) / k)
%                 lengthSum = lengthSum + abs(timeSeries(m + i * k) - timeSeries(m + (i - 1) * k));
%             end
%             Lm(m) = (lengthSum * (N - 1) / floor((N - m) / k)) / k;
%         end
%         % Average length for the current k
%         Lk(k) = mean(Lm);
%     end
% 
%     % Perform linear regression to estimate the fractal dimension
%     logLk = log(Lk);
%     logK = log(1 ./ (1:kMax));
%     coeffs = polyfit(logK, logLk, 1);
%     
%     % The slope of the line is the fractal dimension
%     HFD = -coeffs(1);
% end



function HFD = Higuchi_FD(serie, Kmax) 
%{
Script for computing the Higuchi Fractal Dimension (HDF) of a signal.
INPUT:
    serie: is the temporal series that one wants to analyze by HDF. 
    It must be a row vector.
    Kmax: maximum number of sub-series composed from the original. To
    determine its values, we have followed the recommendation of Doyle et
    al at "Discriminating between elderly and young using a fractal 
    dimension analysis of centre of pressure". 
OUTPUT:
    HFD: the HFD of the temporal series.
PROJECT: Research Master in signal theory and bioengineering - University of Valladolid
DATE: 02/03/2014
AUTHOR: Jes�s Monge �lvarez
%}
%% Checking the ipunt parameters:
control = ~isempty(serie);
assert(control,'The user must introduce a series (first inpunt).');
control = ~isempty(Kmax);
assert(control,'The user must introduce the Kmax parameter (second inpunt).');
%% Processing:
% Composing of the sub-series:
N = length(serie); 
X = NaN(Kmax,Kmax,N);
for k = 1:Kmax
    for m = 1:k
        limit = floor((N-m)/k);
        j = 1;
        for i = m:k:(m + (limit*k))
            X(k,m,j) = serie(i);
            j = j + 1;
        end  
    end
end
% Computing the length of each sub-serie:
L = NaN(1, Kmax);
for k = 1:Kmax
    L_m = zeros(1,k);
    for m = 1:k
        R = (N - 1)/(floor((N - m)/k) * k);
        aux = squeeze(X(k,m,logical(~isnan(X(k,m,:))))); %We get the sub-serie without the NaNs.
        for i = 1:(length(aux) - 1)
            L_m(m) = L_m(m) + abs(aux(i+1) - aux(i));
        end
        L_m(m) = (L_m(m) * R)/k;
    end
    L(k) = sum(L_m)/k;
end
% Finally, we compute the HFD:
x = 1./(1:Kmax);
aux = polyfit(log(x),log(L),1);
HFD = aux(1); %We only want the slope, not the independent term. 
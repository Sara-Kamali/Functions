%This function computes the Katz fractal dimension of the input, which is a one
%dimensional time-series. Where x, is the time vector and y is the amplitude of the data.
%N, is the total number of data points in the data. 

function [KFD,max_dist,eu_length]= Katz_FD(x,y)

N = length(y);Euclidian_dist= zeros(1,N-1);
for i = 1:N-1
    %Euclidian distance between consecutive data points:
    Euclidian_dist(i) = sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);  
end
eu_length = sum(Euclidian_dist);%adding them to get the total Euclidian length of data


%Computing the distances between first data point and all the other data points:
pair_dist = zeros(1,N-1); 
for i = 1:N-1
    pair_dist(i) = sqrt((x(i+1)-x(1))^2 + (y(i+1) - y(1))^2);
end
max_dist = max(pair_dist);%maximum distance between the first point and any other point of data
% Computing KFD:
KFD = log10(N-1)/(log10(N-1) + log10(max_dist/eu_length));

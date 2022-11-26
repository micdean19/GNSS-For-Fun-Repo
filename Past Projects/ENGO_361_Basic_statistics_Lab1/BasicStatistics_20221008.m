%% ENGO Club Meeting #1
% Date: Oct 8th 2022
% By Andreas and Michael.

clc;
clear;
close all;
%% Reading File

% Defining Path, Folder and FileDirectory
% Remember to add backslash after path.
%path = 'C:\Users\micde\Google Drive\GNSS Geo Weekly Club\Past Projects\ENGO_361_Basic_statistics_Lab1\';
path = pwd;
%name = '\Lab1Data.txt';
name = '\Lab1Part1Input.txt';
file_directory= strcat(path,name);

% Now opening FileIO
fstream = fopen(file_directory, 'r');
format_spec ='%f%f%f';

try
    data = textscan(fstream, format_spec, "ReturnOnError", 0);
    data = cell2mat(data);
catch
    disp("Error Failed to read file")
end

%% Part 1 Statistics:

%data(5,3) = 150;
% mean_a = get_mean(data(:,2));
% mean_b = get_mean(data(:,3));
mean_a = mean(data(:,2));
mean_b = mean(data(:,3));
range_a = max(data(:,2)) - min(data(:,2));
range_b = max(data(:,3)) - min(data(:,3));
median_a = median(data(:,2));
median_b = median(data(:,3));

res_a = mean_a - data(:,2);
res_b = mean_b - data(:,3);

sum_res_a = sum(res_a);
sum_res_b = sum(res_b);

mean_res_a = mean(res_a);
mean_res_b = mean(res_b);

var_res_a = var(res_a);
var_res_b = var(res_b);

std_res_a = std(res_a);
std_res_b = std(res_b);

std_mean_a = std_res_a/sqrt(length(data));
std_mean_b = std_res_b/sqrt(length(data));

P_a = 1/(std_mean_a)^2;
P_b = 1/(std_mean_b)^2;

wmean = ((P_a*mean_a) + (P_b * mean_b))/(P_a + P_b);

figure
hold on
plot(data(:,2));
plot(data(:,3));
yline(mean_a);
yline(mean_b);
yline(wmean);
xlabel('Meas. No.');
ylabel('Distance');
title('Observers A and B Distance Measurement');
legend('Observer A', 'Observer B', 'Mean A', 'Mean B', 'Weighted Mean of A and B');

figure
hist(res_a);

figure
hist(res_b);


function xmean = get_mean(x)
    number_of_x = 0;
    x_total = 0;
    
    for i=1:length(x)
        x_total = x_total+x(i);
        number_of_x = number_of_x + 1;
    end

    xmean = x_total/number_of_x;

end






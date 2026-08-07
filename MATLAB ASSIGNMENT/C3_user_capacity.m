clear; clc; close all;

capacity4G = 200;
capacity5G = 1000;

values = [capacity4G, capacity5G];
labels = {'4G Capacity: 200', '5G Capacity: 1000'};

figure;
pie(values, labels);

title('User Capacity Comparison');
colormap([0 0.4470 0.7410; 0.4660 0.6740 0.1880]);  % blue for 4G, green for 5G
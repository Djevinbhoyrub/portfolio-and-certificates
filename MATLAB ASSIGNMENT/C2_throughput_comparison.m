clear; clc; close all;

% Example throughput values (Mbps) for comparison
throughput4G = 20 * 20;    % bandwidth 20 MHz x efficiency 20 bits/s/Hz (example)
throughput5G = 100 * 8;    % bandwidth 100 MHz x efficiency 8 bits/s/Hz (example)

categories = categorical({'4G LTE', '5G NR'});
categories = reordercats(categories, {'4G LTE', '5G NR'});  % keep this exact order
values = [throughput4G, throughput5G];

figure;
bar(categories, values, 0.5);

title('Throughput Comparison');
xlabel('Technology');
ylabel('Throughput (Mbps)');
grid on;
clear; clc; close all;

distance = 0:100:2000;

signal4G = 100 - (distance / 20);
signal5G = 100 - (distance / 15);

% Clamp negative values to 0 (signal can't go below 0%)
signal4G(signal4G < 0) = 0;
signal5G(signal5G < 0) = 0;

figure;
plot(distance, signal4G, 'b-o', 'LineWidth', 1.5); hold on;
plot(distance, signal5G, 'r-s', 'LineWidth', 1.5);

title('Signal Strength vs Distance');
xlabel('Distance (m)');
ylabel('Signal Strength (%)');
legend('4G', '5G');
grid on;
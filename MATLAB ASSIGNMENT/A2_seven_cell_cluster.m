clear; clc; close all;
figure; hold on; axis equal;

R = 3;                          % cell radius
centerDist = R * sqrt(3);       % distance between adjacent cell centers
angles = 0:60:300;              % 6 directions around the center cell

% Centers of all 7 cells: cell 7 = middle, cells 1-6 = surrounding
centersX = [centerDist*cosd(angles), 0];
centersY = [centerDist*sind(angles), 0];

cellNumbers = {'1','2','3','4','5','6','7'};
freqGroups  = {'A','B','C','A','B','C','-'};  % reuse pattern

for i = 1:7
    drawHexCell(centersX(i), centersY(i), R, cellNumbers{i}, freqGroups{i});
end

title('7-Cell Cluster with Frequency Reuse');
xlabel('X (km)'); ylabel('Y (km)');
grid on;

% ---- Local function: draws ONE hexagon cell with BS, number, freq label ----
function drawHexCell(cx, cy, R, cellNum, freqLabel)
theta = linspace(0, 2*pi, 7) + pi/6;
hexX = cx + R * cos(theta);
hexY = cy + R * sin(theta);
plot(hexX, hexY, 'b-', 'LineWidth', 1.5);

plot(cx, cy, '^', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

text(cx, cy + 1.3, cellNum, 'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold', 'FontSize', 12);
text(cx, cy - 1.3, freqLabel, 'HorizontalAlignment', 'center', ...
    'Color', 'm', 'FontWeight', 'bold');
end
clear; clc; close all;
figure; hold on; axis equal;

R = 3;

% --- Two adjacent hexagon centers, side by side ---
cellA_center = [0, 0];
cellB_center = [R*sqrt(3), 0];   % placed directly to the right of Cell A

drawHexCell(cellA_center(1), cellA_center(2), R, 'Cell A');
drawHexCell(cellB_center(1), cellB_center(2), R, 'Cell B');

% --- User path: starts inside Cell A, ends inside Cell B ---
userStart = [-2, 0.5];
userEnd   = [4, -0.5];
handoverPoint = [cellA_center(1) + R*sqrt(3)/2, 0];  % midpoint between the two BS

plot(userStart(1), userStart(2), 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 10);
text(userStart(1), userStart(2)-0.7, 'UE start', 'HorizontalAlignment', 'center');

plot(userEnd(1), userEnd(2), 'ks', 'MarkerFaceColor', 'g', 'MarkerSize', 10);
text(userEnd(1), userEnd(2)-0.7, 'UE end', 'HorizontalAlignment', 'center');

plot([userStart(1) userEnd(1)], [userStart(2) userEnd(2)], 'r--', 'LineWidth', 1.5);

plot(handoverPoint(1), handoverPoint(2), 'kx', 'MarkerSize', 14, 'LineWidth', 3);
text(handoverPoint(1), handoverPoint(2)+0.5, 'Handover Point', ...
    'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'k');

title('Handover Illustration Between Two Adjacent Cells');
xlabel('X (km)'); ylabel('Y (km)');
grid on;

% ---- Local function: draws one hexagon with BS and a label ----
function drawHexCell(cx, cy, R, cellLabel)
theta = linspace(0, 2*pi, 7) + pi/6;
hexX = cx + R * cos(theta);
hexY = cy + R * sin(theta);
plot(hexX, hexY, 'b-', 'LineWidth', 1.5);

plot(cx, cy, '^', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
text(cx, cy - R - 0.5, cellLabel, 'HorizontalAlignment', 'center', ...
    'FontWeight', 'bold', 'FontSize', 11);
text(cx, cy + 0.5, 'BS', 'HorizontalAlignment', 'center');
end
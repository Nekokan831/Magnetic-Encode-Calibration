close all
clear all
% 定数の設定
L = 1;          % IC本体の磁界の大きさ (例)
d_x = 0;        % 回転中心とエンコーダの x 方向のずれ (例)
d_y = 0;        % 回転中心とエンコーダの y 方向のずれ (例)
phi = 0;       % y軸周りのズレ角度 phi (度単位) (例)
psi = 0;       % x軸周りのズレ角度 psi (度単位) (例)
D = 0;        % 外乱磁界の大きさ定数 D (例)
alpha = 0;     % x-y平面のなす角度 alpha (度単位) (例)
beta = 0;      % xy-z平面のなす角度 beta (度単位) (例)

% パラメータ変換
phi = deg2rad(phi);
psi = deg2rad(psi);
alpha = deg2rad(alpha);
beta = deg2rad(beta);

% 角度 theta の範囲 (度単位)
theta_deg = 0:1:360;           % 0度から360度
theta_rad = deg2rad(theta_deg); % ラジアンに変換

% B_x と B_y の計算
B_x = (L ./ (1 + d_x^2 + d_y^2)) .* cos(theta_rad - atan2(d_y , d_x)) * cos(phi) + ...
      D * cos(alpha) * cos(beta) * cos(phi);

B_y = (L ./ (1 + d_x^2 + d_y^2)) .* sin(theta_rad - atan2(d_y , d_x)) * cos(psi) + ...
      D * sin(alpha) * cos(beta) * cos(psi);

% % B_x と B_y の計算
% B_x = L.* cos(theta_rad) * cos(phi) + D * cos(alpha) * cos(beta) * cos(phi);
% 
% B_y = L.* sin(theta_rad) * cos(psi) + D * sin(alpha) * cos(beta) * cos(psi);

% 理想的なリサージュ波形の計算
ideal_B_x = L * cos(theta_rad);
ideal_B_y = L * sin(theta_rad);

% グラフのプロット
figure;
plot(theta_deg, B_x, 'b', 'LineWidth', 1.5, 'DisplayName', 'B_x');
hold on;
plot(theta_deg, B_y, 'r', 'LineWidth', 1.5, 'DisplayName', 'B_y');
hold off;
xlabel('\theta (degrees)');
ylabel('B');
title('B_x and B_y vs \theta');
legend('show');
grid on;

% リサージュ波形のプロット
figure;
plot(B_x, B_y, 'b', 'LineWidth', 1.5, 'DisplayName', 'Actual B_x and B_y');
hold on;
plot(ideal_B_x, ideal_B_y, 'color', [0.5 0.5 0.5], 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Ideal B_x and B_y');
hold off;
xlabel('B_x');
ylabel('B_y');
title('Lissajous Figure of B_x and B_y with Ideal');
legend('show');
grid on;
axis equal;
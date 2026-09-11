%% A13 PCM FAILURE COMPARISON
% Run this script after creating:
%   PCM_data   = with-PCM simulation timeseries
%   noPCM_data = without-PCM simulation timeseries
%
% Example:
%   PCM_data = out.Tchamber_PCM;
%   noPCM_data = out.Tchamber_noPCM;

clearvars -except PCM_data noPCM_data

% Extract data
t_pcm = PCM_data.Time;
T_pcm = PCM_data.Data;

t_no = noPCM_data.Time;
T_no = noPCM_data.Data;

% Convert time to hours
t_pcm_h = t_pcm / 3600;
t_no_h  = t_no / 3600;

% Compressor failure
failure_time_s = 43200;
failure_time_h = 12;

[~, idx_pcm] = min(abs(t_pcm - failure_time_s));
[~, idx_no]  = min(abs(t_no - failure_time_s));

T_failure_PCM   = T_pcm(idx_pcm);
T_failure_noPCM = T_no(idx_no);

% Final values
T_final_PCM   = T_pcm(end);
T_final_noPCM = T_no(end);

% Temperature rise after failure
rise_PCM   = T_final_PCM - T_failure_PCM;
rise_noPCM = T_final_noPCM - T_failure_noPCM;

% PCM effect
temperature_reduction = T_final_noPCM - T_final_PCM;

fprintf('\n============================================\n');
fprintf('       A13 PCM FAILURE RESILIENCE TEST\n');
fprintf('============================================\n');

fprintf('\nTemperature at compressor failure (12 h):\n');
fprintf('With A13 PCM : %.4f °C\n', T_failure_PCM);
fprintf('Without PCM   : %.4f °C\n', T_failure_noPCM);

fprintf('\nFinal temperature at 18 h:\n');
fprintf('With A13 PCM : %.4f °C\n', T_final_PCM);
fprintf('Without PCM   : %.4f °C\n', T_final_noPCM);

fprintf('\nTemperature rise after compressor failure:\n');
fprintf('With A13 PCM : %.4f °C\n', rise_PCM);
fprintf('Without PCM   : %.4f °C\n', rise_noPCM);

fprintf('\nTemperature reduction due to A13 PCM:\n');
fprintf('%.4f °C\n', temperature_reduction);

fprintf('\n============================================\n');

% Plot
figure('Color','white');

plot(t_pcm_h, T_pcm, 'LineWidth', 2);
hold on;
plot(t_no_h, T_no, 'LineWidth', 2);

yline(15, '--', '15°C threshold', 'LineWidth', 1.3);
xline(failure_time_h, '--', 'Compressor failure', 'LineWidth', 1.3);

xlabel('Time (hours)');
ylabel('Chamber Temperature (°C)');
title('A13 PCM Thermal Buffering During Compressor Failure');

legend('With A13 PCM', ...
       'Without PCM', ...
       '15°C threshold', ...
       'Compressor failure', ...
       'Location','northwest');

grid on;
xlim([0 18]);

hold off;

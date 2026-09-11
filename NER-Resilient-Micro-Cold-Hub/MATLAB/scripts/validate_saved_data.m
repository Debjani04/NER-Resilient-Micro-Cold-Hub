%% VALIDATE SAVED A13 PCM DATA
% Checks that the two saved simulation datasets are different.
%
% Required variables:
%   PCM_data
%   noPCM_data

if ~exist('PCM_data','var')
    error('PCM_data does not exist. Save the with-PCM simulation first.');
end

if ~exist('noPCM_data','var')
    error('noPCM_data does not exist. Save the without-PCM simulation first.');
end

t_pcm = PCM_data.Time;
T_pcm = PCM_data.Data;

t_no = noPCM_data.Time;
T_no = noPCM_data.Data;

fprintf('PCM samples    : %d\n', numel(T_pcm));
fprintf('No-PCM samples : %d\n', numel(T_no));

fprintf('PCM final      : %.4f °C\n', T_pcm(end));
fprintf('No-PCM final   : %.4f °C\n', T_no(end));

if numel(T_pcm) == numel(T_no)
    max_difference = max(abs(T_pcm - T_no));
    fprintf('Maximum pointwise difference: %.6f °C\n', max_difference);

    if max_difference == 0
        warning(['The two datasets are identical. They were probably logged ' ...
                 'from the same Tchamber signal rather than from two separate runs.']);
    end
end

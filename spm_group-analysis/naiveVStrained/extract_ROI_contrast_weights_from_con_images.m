% script extract BETA values from con.nii images within a ROI
% (subject-wise)
LoadSPM()

%
dirROI        = fullfile(pwd, 'ROI');
dirOutput     = fullfile(pwd, 'extracted_betas');
%
%
% ROI (trained participants)
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_BA10.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_BA11.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_IPL.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_RSC.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_se>su_BA10.nii');
roi_nii = fullfile(dirROI, 'cuetarget','active_trained_se>su_leftIPL.nii');

% ROI (naive participants; uses ROI from trained participants!)
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_IPL.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_RSC.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_BA10.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_likely>unlikely_BA11.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_se>su_BA10.nii');
%roi_nii = fullfile(dirROI, 'cuetarget','active_trained_se>su_leftIPL.nii');

[ROIfilepath,ROIname,ROIext] = fileparts(roi_nii);

Vroi = spm_vol(roi_nii);
roi  = spm_read_vols(Vroi) > 0;

if contains(roi_nii,'ROI/cuetarget/')
    dirFirstLevel_cuetarget = '/data/projects/sfb_cuetarget/derivatives/spm_first-level/s8_glm_3_cue/firstlevel';

    %%
    profile_names = { ...
        'short exp active day4 HRF', ...
        'short unexp active day4 HRF', ...
        'long exp active day4 HRF', ...
        'long unexp active day4 HRF'};

    %%%%%
    %% trained
    % ===== LOAD SPM.mat =====
    load(fullfile(dirFirstLevel_cuetarget,'sub-009', 'SPM.mat'));
    %
    % SPM.xCon(3).name   % 'short exp active day4 HRF'
    % SPM.xCon(9).name   % 'short unexp active day4 HRF'
    % SPM.xCon(55).name  % 'long exp active day4 HRF'
    % SPM.xCon(61).name  % 'long unexp active day4 HRF'

    con_names = strings(1, numel(profile_names));
    for k = 1:numel(profile_names)
        hits = find(strcmp({SPM.xCon.name}, profile_names{k}));
        if numel(hits) ~= 1
            error('Kontrastname "%s" nicht eindeutig gefunden (%d Treffer).', profile_names{k}, numel(hits));
        end
        con_names(k) = SPM.xCon(hits).Vcon.fname;
    end

    % all subjects
    subjects_cuetarget = {'009', '011', '012', '013', '014', '015', '016', ...
        '017', '019', '020', '022', '023', '024', '027', ...
        '028', '029', '030', '031', '032', '033', '034', '035', ...
        '037', '038', '039', '040', '041', '042', '043', '044', '045', ...
        '046', '047', '053', '054'};

    cell_mean = nan(numel(subjects_cuetarget), numel(profile_names));

    for sub = 1:numel(subjects_cuetarget)
        subject = subjects_cuetarget(sub);
        if iscell(subject), subject = subject{1}; end

        for c = 1:numel(con_names)
            contrast = char(con_names(c));

            file = sprintf('%s/sub-%s/%s',dirFirstLevel_cuetarget,subject,contrast);

            V = spm_vol(file);
            if isempty(V)
                error('spm_vol konnte Datei nicht laden: %s', file);
            end

            img = spm_read_vols(V);
            vals = img(roi);
            cell_mean(sub,c) = mean(vals, 'omitnan');
        end
    end

    T = array2table(cell_mean);

    T.Properties.VariableNames = {...
        'early_likely', 'early_unlikely', 'late_likely', 'late_unlikely'};

    % save
    fileName = sprintf('%s/cuetarget/%s.csv',dirOutput,ROIname);
    writetable(T,fileName);


elseif contains(roi_nii,'ROI/diract/')

    dirFirstLevel_diract    = '/data/projects/sfb_diract/scratch/sfb_diract/derivatives/spm_first-level/s8_glm_3_cue';

    %%
    profile_names = { ...
        'short exp active day1 HRF', ...
        'short unexp active day1 HRF', ...
        'long exp active day1 HRF', ...
        'long unexp active day1 HRF'};

    %%%%%
    %% naive
    % ===== LOAD SPM.mat =====
    load(fullfile(dirFirstLevel_diract,'sub-009', 'SPM.mat'));
    % SE SPM.xCon(1).name  % 'short exp active day1 HRF'
    % SU SPM.xCon(3).name  % 'short unexp active day1 HRF'
    % LE SPM.xCon(11).name % 'long exp active day1 HRF'
    % LU SPM.xCon(13).name % 'long unexp active day1 HRF'

    con_names = strings(1, numel(profile_names));
    for k = 1:numel(profile_names)
        hits = find(strcmp({SPM.xCon.name}, profile_names{k}));
        if numel(hits) ~= 1
            error('Kontrastname "%s" nicht eindeutig gefunden (%d Treffer).', profile_names{k}, numel(hits));
        end
        con_names(k) = SPM.xCon(hits).Vcon.fname;
    end

    % all subjects
    subjects_diract = {'001', '002', '004', '005', '006', '007', '008', ...
                        '009', '010', '011', '012', '013', '014', '015', '016', '018'};

    cell_mean = nan(numel(subjects_diract), numel(profile_names));

    for sub = 1:numel(subjects_diract)
        subject = subjects_diract(sub);
        if iscell(subject), subject = subject{1}; end

        for c = 1:numel(con_names)
            contrast = char(con_names(c));

            file = sprintf('%s/sub-%s/%s',dirFirstLevel_diract,subject,contrast);

            V = spm_vol(file);
            if isempty(V)
                error('spm_vol konnte Datei nicht laden: %s', file);
            end

            img = spm_read_vols(V);

            vals = img(roi);

            cell_mean(sub,c) = mean(vals, 'omitnan');
        end
    end

    T = array2table(cell_mean);

    T.Properties.VariableNames = {...
        'early_likely', 'early_unlikely', 'late_likely', 'late_unlikely'};

    % save
    ROIname = "active_naive_earlylikely>earlyunlikely_IPL_cuetarget";
    fileName = sprintf('%s/diract/%s.csv',dirOutput,ROIname);
    writetable(T,fileName);
end



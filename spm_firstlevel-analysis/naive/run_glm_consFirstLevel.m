% create first level contrast
%
% calculate first-level contrasts (definition of which is in
% `Generate_FirstLevelContrastBatch.m`)
%

%% choose which preprocessing based first level GLM results to use
pipeline = 'fmriprep';

%% important: tmod can be included in GLM model or not
tmod = 0; % no tmod

%% important: different first level folders possible
iFirstLevel = "firstlevel";

if tmod == 0
    iFirstLevel = iFirstLevel;
end

%% start contrast manager script
subjects = {'001', '002', '004', '005', '006', '007', '008', '009', '010' ...
    '011', '012', '013', '014', '015', '016', '018'};

% all smoothings
smoothings = [8];

for subject = subjects
    for smoothing = smoothings
        subject = char(subject);
        assert(ischar(subject),'variable `subject` must be a strnig.');

        % all models per subject and smoothing
        modelName3 = sprintf('s%g_glm_3_cue',smoothing);    % cue onsets, hrf + temp + disp

        for modelName = {modelName3}
            if iscell(modelName); modelName = modelName{1}; end

            %% prep SPM
            LoadSPM();

            dirProjectRoot = '/data/projects/sfb_diract/scratch/sfb_diract/derivatives/spm_first-level';

            filenameSPMMat = sprintf('%s/%s/sub-%s/SPM.mat',...
                dirProjectRoot,modelName,subject);

            if exist(filenameSPMMat,'file')

                %% initialize SPM batch job manager
                fprintf('running contrasts %s for subject %s\n',modelName, subject);

                % decide which contrast matlab batch to use
                %% create matlabbatch
                disp('BATCH: hrf, temporal and dispersion derivatives are applied')
                % all sessions first level approach (original approach)
                % generate matlabbatch based on template which references 'subject'
                matlabbatch = Generate_FirstLevelContrastBatch(filenameSPMMat);

                %% run batch
                spm_jobman('run', matlabbatch);

                % plot overview of calculated contrasts (sanity check)
                CheckContrasts(filenameSPMMat)

                fprintf('done running model %s for subject %s\n',modelName, subject);

                matlabbatch = {};

            else
                fprintf('SPM file not found (%s)\n',filenameSPMMat);
            end
        end
    end
end

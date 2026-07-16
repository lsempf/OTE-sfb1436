function  matlabbatch = run_glm1level_fmriprep(subject)
% performs 1st level GLM analysis with fmriprep output files
% run first-level GLM for specified subject and smoothing
% "The referenced glm-batch models all iterations of the task (day 1
% active) in one single 1st level GLM"

% start this script as: run_glm1level('009','6') or run_glm1level('009','8')
%
dirProject = '/data/projects/sfb_diract/scratch/sfb_diract';
tmod = 0;
pmod = 0;
design = "delay:expectation"
corrected4RT = "no"

subject = char(subject)
assert(ischar(subject),'variable `subject` must be a strnig.');

smoothing = '8';
smoothing = str2num(smoothing);

% in each of the 4 runs we have 4 conditions (LongExpected, Long
% Unexpected, ShortExpected, ShortUnexpected) and per condition we model
% the basis hrf function, the temporal derivative and the dispersion
% derivative! Furthermore we have the 6 realignment parameters for each run!

% different model approaches are used to create design matrix and estimate
% the model
modelName3 = sprintf('s%g_glm_3_cue',smoothing);

for modelName = {modelName3}
    if iscell(modelName); modelName = modelName{1}; end

    fprintf('running model %s for subject %s\n',modelName, subject);

    %% define directories
    dirProjectRoot          = '/data/projects/sfb_diract/scratch/sfb_diract/derivatives/spm_first-level';

    % get output dir
    dirOutput               = sprintf('%s/%s/sub-%s/',...
        dirProjectRoot, modelName, subject)

    %% input for first level glm:
    dirDerivatives          = sprintf('/data/projects/sfb_diract/scratch/sfb_diract/derivatives/fmriprep_preproc');

    %% prep SPM
    LoadSPM();

    %% make sure output folder exists
    [~,~,~] = mkdir(dirOutput);
    % but is also empty
    delete(sprintf('%s/*',dirOutput));

    %% define matlabbatch template
    matlabbatch = {}; % be sure to start with empty batch
    disp('BATCH: hrf, temporal and dispersion derivatives are applied')
    run(sprintf('%s/code/spm_first-level/spm_batches/spm_firstLevelGLM',dirProject));

    nDataSessions = 0;

    for session = [1]
        for task = {'active'}
            if iscell(task); task = task{1}; end
            for iRun = 1:4
                nDataSessions = nDataSessions + 1; % zaehlt ses1 bis 4 hoch

                % define Highpassfilter
                matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).hpf = 128;

                %% smoothed niftis (fmriprep output
                matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).scans =...
                    cellstr(spm_select('expand',...
                    sprintf(['%s/sub-%s/ses-%03i/func/' ...
                    's%gsub-%s_ses-%03i_task-%s_run-%i_space-MNI152NLin2009cAsym_desc-preproc_bold.nii'],...
                    dirDerivatives,subject,session, ... % path
                    smoothing,subject,session,task,iRun)));

                %% conditions
                if design == "delay:expectation"
                    % for each trial type:
                    % iCondition = ["longExpected"]
                    for iCondition = ["longExpected","longUnexpected","shortExpected","shortUnexpected"]

                        % get order of conditions in order to find right column in
                        % onsets.mat file!
                        if iCondition == "longExpected"
                            iConditionN = "longExpected";
                            iNummer = 1;
                        elseif iCondition == "longUnexpected"
                            iConditionN = "longUnexpected";
                            iNummer = 2;
                        elseif iCondition == "shortExpected"
                            iConditionN = "shortExpected";
                            iNummer = 3;
                        elseif iCondition == "shortUnexpected"
                            iConditionN = "shortUnexpected";
                            iNummer = 4;
                        end

                        iCondition = char(iCondition);

                        % 1-4               %1-4
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).cond(iNummer).name = iCondition;
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).cond(iNummer).duration = 0.1;

                        % chose right condition file
                        fprintf('BATCH: use cue onsets in run-%i\n',iRun)
                        onsetsData = importdata(sprintf(['%s/sub-%s/ses-%03i/func/'...
                            'sub-%s_ses-%03i_task-%s_run-%i_cue_events.mat'],...
                            dirDerivatives, subject,session, ...
                            subject, session, task, iRun));

                        % add onsets
                        matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).cond(iNummer).onset = ...
                            onsetsData.onsets{iNummer};

                        clear('onsetsData')

                    end
                end

                %% add realignment parameters
                matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).multi_reg = {...
                    sprintf(['%s/sub-%s/ses-%03i/func/'...
                    'rp_sub-%s_ses-%03i_task-%s_run-%i_bold.txt'],...
                    dirDerivatives, subject,session, ....
                    subject, session, task, iRun)};

            end
        end
    end
end

matlabbatch{1}.spm.stats.fmri_spec.dir = {dirOutput};

%% check
assert(length(matlabbatch{1}.spm.stats.fmri_spec.sess) == 4, ...
    'ERROR in specifying nifites for SPM-first level glm; expecting 4 but got %i', ...
    length(matlabbatch{1}.spm.stats.fmri_spec.sess));

% save log info for later reference
save(sprintf('%s/code/spm_first-level/spm_batches_log/sub-%s_glm_pmod_bt_evidence_first_RT',...
    dirProject,subject));

% and run job
spm_jobman('run', matlabbatch);

fprintf('done running model %s for subject %s\n',modelName, subject);

end

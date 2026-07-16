function  matlabbatch = run_glm1level_fmriprep(subject,smoothing)
% performs 1st level GLM analysis with fmriprep output files
% run first-level GLM for specified subject and smoothing
% "The referenced glm-batch models all three iterations of the task (day 1
% passive, day 4  passive & active) in one single 1st level GLM"

% start this script as: run_glm1level('009','6') or run_glm1level('009','8')

tmod = 0; 
pmod = 0; 
design = "delay:expectation"
corrected4RT = "no"

subject = char(subject)
assert(ischar(subject),'variable `subject` must be a strnig.');

smoothing = '8';
smoothing = str2num(smoothing);

modelName3 = sprintf('s%g_glm_3_cue',smoothing);    % cue onsets, hrf + temp + disp

for modelName = {modelName3}
    if iscell(modelName); modelName = modelName{1}; end
    
    fprintf('running model %s for subject %s\n',modelName, subject);
    
    %% define directories
    dirProjectRoot          = '/home/data/sfb_cuetarget/analysis';
    
    % get output dir
    dirOutput               = sprintf('%s/glm_analysis_fmriprep/%s/firstlevel/sub-%s/',...
        dirProjectRoot, modelName, subject);

    %% input for first level glm:
    dirDerivatives          = sprintf('/home/data/sfb_cuetarget/derivatives/fmriprep');
    
    %% prep SPM
    LoadSPM();
    
    %% make sure output folder exists
    [~,~,~] = mkdir(dirOutput);
    % but is also empty
    delete(sprintf('%s/*',dirOutput));
    
    %% define matlabbatch template
    matlabbatch = {}; % be sure to start with empty batch
    
    disp('BATCH: hrf, temporal and dispersion derivatives are applied')
    run(sprintf('%s/code/glm_analysis/spm_batches/spm_firstLevelGLM',dirProjectRoot));

    %% loop
    nDataSessions = 0;

    for session = [1 4]
        for task = {'passive','active'}

            if iscell(task); task = task{1}; end
            if strcmp(task,'active') && session == 1; continue; end

            for iRun = 1:4
                nDataSessions = nDataSessions + 1; % zaehlt ses1 bis 12 hoch

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
                % for each trial type:
                for iCondition = ["longExpected","longUnxpected","shortExpected","shortUnexpected"]

                    if iCondition == "longExpected"
                        iConditionN = "longExpected";
                        iNummer = 1;
                    elseif iCondition == "longUnxpected"
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

                    % 1-12              %1-4
                    matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).cond(iNummer).name = iCondition;
                    matlabbatch{1}.spm.stats.fmri_spec.sess(nDataSessions).cond(iNummer).duration = 0.1;

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

                % add realignment parameters
                % adds realignment parameters for a run
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
assert(length(matlabbatch{1}.spm.stats.fmri_spec.sess) == 12, ...
    'ERROR in specifying nifites for SPM-first level glm; expecting 12 but got %i', ...
    length(matlabbatch{1}.spm.stats.fmri_spec.sess));

% and run job
spm_jobman('run', matlabbatch);

fprintf('done running model %s for subject %s\n',modelName, subject);

end




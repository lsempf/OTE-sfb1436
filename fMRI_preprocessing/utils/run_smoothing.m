% This script runs smoothing for func epis and GM/ WM segments created with
% fmriprep

function  matlabbatch = run_smoothing(subject,dirData,kernel)
kernel = 8

disp(kernel)

if kernel == 0

    % do nothing



else

    fprintf('preprocessing subject %s (files expected under: %s)\n',subject, dirData);
    addpath('/data/projects/sfb_diract/scratch/sfb_diract/code/software/spm12')
    % define working dir as relative to this scripts location
    dir_me = fileparts(mfilename('fullpath'));

    %===============================================================================
    %% Smoothing func epis
    matlabbatch = {}; % be sure to start with empty batch

    % define matlabbatch
    matlabbatch{1}.spm.spatial.smooth.data = {};
    matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 's8';

    % overwrite subject-specific stuff
    %--------------------------------------------------------------------------
    niftis = {};
    tasks = {'active'};
    sessions = [1];
    runs = 1:4;

    for session = sessions
        for task = tasks

            for iRun = runs
                % add multiband bold EPIs
                bold_nii = GetFiles(sprintf(...
                    '%s/sub-%s/ses-%03i/func/sub-%s_ses-%03i_task-%s_run-%i_*_bold_*.nii',...
                    dirData,subject,session, subject,session, task{1}, iRun));
                fprintf('ses-%03i_task-%s_run-%i - nImages: %i\n', session, task{1},iRun,size(bold_nii,1));
                niftis = [niftis; cellstr(bold_nii)];
            end
        end
    end
    matlabbatch{1}.spm.spatial.smooth.data = niftis;

    % save batch for later reference
    save(sprintf('%s/log_spm_batches/sub-%s_smooth_fmriprep_aftercare.mat',...
        dir_me,subject),'matlabbatch');

    % run job
    spm_jobman('run', matlabbatch);

    %===============================================================================
    %% Smoothing segments (for VBM)
    disp('starting smoothing the anatomical segments')
    matlabbatch = {}; % be sure to start with empty batch

    % define matlabbatch
    matlabbatch{1}.spm.spatial.smooth.data = {};
    matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];
    matlabbatch{1}.spm.spatial.smooth.dtype = 0;
    matlabbatch{1}.spm.spatial.smooth.im = 0;
    matlabbatch{1}.spm.spatial.smooth.prefix = 's8';

    % overwrite subject-specific stuff
    %--------------------------------------------------------------------------
    niftis = {};
    segments_nii = GetFiles(sprintf(...
        '%s/sub-%s/ses-%03i/anat/sub-%s_ses-%03i_space-MNI152NLin2009cAsym_label-*.nii',...
        dirData,subject,session,subject,session));
    niftis = [niftis; cellstr(segments_nii)];
    matlabbatch{1}.spm.spatial.smooth.data = niftis;
    
    % save batch for later reference
    save(sprintf('%s/log_spm_batches/sub-%s_smooth_fmriprep_aftercare_segments.mat',...
        dir_me,subject),'matlabbatch');

    disp('now starting the SPM job')

    % run job
    spm_jobman('run', matlabbatch);

    %===============================================================================
    %% close up.
    fprintf(' done smoothing subject %s\n',subject);

end

end

function run_convert4Dto3D_fmriprep(subject, dirData, dirOutput)

fprintf('converting 4D functional images of subject %s\n(files takes from %s and written to %s)\n',...
    subject,dirData, dirOutput);

addpath('/data/projects/sfb_diract/scratch/sfb_diract/code/software/spm12')

% define working dir as relative to this scripts location
dir_me = fileparts(mfilename('fullpath'))

% make sure output folder exists
[~,~,~]=mkdir(dirOutput);

%% initialize SPM batch job manager
% spm_jobman('initcfg')

%% run conversion
% generate matlabbatch based on template which references 'subject'
matlabbatch = {}; % be sure to start with empty batch
run(sprintf('%s/spm_batches/convert4Dto3D_fmriprep.m',dir_me))

save(sprintf('%s/log_spm_batches/sub-%s_4Dto3D_fmriprep.mat',dir_me,subject),'matlabbatch');
spm_jobman('run', matlabbatch);

fprintf('done with file 4D to 3D conversion for subject %s\n',subject);

quit
end

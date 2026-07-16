function LoadSPM()

addpath('/data/projects/sfb_diract/scratch/sfb_diract/code/software/spm12') % use this specific SPM12 version
%addpath('/Users/lindasempf/Documents/MATLAB/spm12')
spm('defaults','FMRI');
spm_jobman('initcfg');

end
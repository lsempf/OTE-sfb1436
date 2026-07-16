function LoadSPM()

addpath('/home/data/sfb_cuetarget/spm12') % use this specific SPM12 version
spm('defaults','FMRI');
spm_jobman('initcfg');

end
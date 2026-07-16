% convert smoothed 3D images into a single 4D one
function run_3Dto4D_fmriprep(subject,smoothing,dirData,dirOutput)

smoothing = 8

smoothing=num2str(smoothing);

fprintf('creating 4D niftis for subject %s\n  3D files expected under: %s\n  4D files will be under: %s\n',...
    subject, dirData, dirOutput);
dir_me = fileparts(mfilename('fullpath'));

addpath('/data/projects/sfb_diract/scratch/sfb_diract/code/software/spm12')

%% create matlabbatch jobs
matlabbatch = {};
i = 0;
tasks = {'active'};
sessions = [1];
runs = 1:4;

for session = sessions
    for task = tasks
        for iRun = runs
            % define filepattern of input
            pattern = sprintf('%s/sub-%s/ses-%03i/func/s%ssub-%s_ses-%03i_task-%s_run-%i_space-MNI152NLin2009cAsym_desc-preproc_bold_*.nii',...
                dirData, subject,session,... % path
                smoothing, subject,session, task{1}, iRun); % filename

            % collect files from one run
            bold_nii = GetFiles(pattern);

            if ~isempty(bold_nii)
                % if any files: create next job
                i = i + 1;
                fprintf('ses-%03i_task-%s_run-%i - nImages: %i\n', session, task{1},iRun,size(bold_nii,1));

                filenameOutput = sprintf('%s/sub-%s/ses-%03i/func/s%ssub-%s_ses-%03i_task-%s_run-%i_space-MNI152NLin2009cAsym_desc-preproc_bold.nii', ...
                    dirOutput,subject,session,... % path
                    smoothing,subject,session, task{1}, iRun); % filename

                % make sure output folder exists
                [~,~,~] = mkdir(fileparts(filenameOutput));

                % and create the matlabbatch
                matlabbatch{i}.spm.util.cat.vols = cellstr(bold_nii);
                matlabbatch{i}.spm.util.cat.name = filenameOutput;
                matlabbatch{i}.spm.util.cat.dtype = 0;
                matlabbatch{i}.spm.util.cat.RT = 2;
            else
                fprintf('no files found matching pattern:\n%s\n', pattern);
            end
        end
    end
end

% save matlabbatch for later reference
save(sprintf('%s/log_spm_batches/sub-%s_3Dto4D.mat',dir_me,subject),'matlabbatch');

%% run jobs
spm_jobman('run', matlabbatch);


end

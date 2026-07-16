% run 2nd level flexible factorial GLM

iDerivative = "hrf";
cov = "rt";
analysisName = 'flex_fact_RT_interaction';

%%
for pipeline = {'fmriprep'}
    if iscell(pipeline); pipeline = pipeline{1}; end
    for smoothing = [8]
        for time_lock={'cue'}
            if iscell(time_lock); time_lock = time_lock{1}; end
            time_lock = char(time_lock);

            %% pick models
            % all possible models per time_lock, smoothing and pipeline
            modelName1 = sprintf('s%g_glm_3_%s',smoothing,time_lock); % hrf + temp + disp

            for modelName = {modelName1}
                if iscell(modelName); modelName = modelName{1}; end

                owerwrite = 1;
                dirProjectRoot = '/data/projects/sfb_cuetarget/derivatives/spm_first-level';
                dirCode = '/data/projects/sfb_cuetarget/code/glm_analysis';

                %% grab names & type of contrasts from 1st level definition in spm_batch file
                filenameSPMMat = sprintf('%s/%s/firstlevel/sub-009/SPM.mat',... 
                    dirProjectRoot, modelName);

                %% dir firstlevel
                dirFirstlevel = sprintf('%s/s%g_glm_3_%s/firstlevel',...
                    dirProjectRoot,smoothing,time_lock);

                %%
                fprintf('running %s for %s\n',...
                    analysisName,modelName)

                % define where to put files
                dirOutput = sprintf('/data/projects/sfb_cuetarget/derivatives/spm_2ndLevel/%s/ohne_sub036/%s', ...
                    modelName,analysisName);

                [~,~,~] = mkdir(dirOutput);
                if owerwrite == 1
                    delete(sprintf('%s/*',dirOutput));
                end

                % load template of spmBatch
                matlabbatch = {};
                run(sprintf('%s/spm_secondLevel_flex_fact_RT_only_interaction.m',...
                    dirCode))

                %% overwrite contrast-specific stuff
                matlabbatch{1}.spm.stats.factorial_design.dir = {dirOutput};

                %% contrast niftis
                % model with 3 parameters
                % con_0003.nii = 'short exp active day4 HRF'
                % con_0009.nii = 'short unexp active day4 HRF'
                % con_0055.nii = 'long exp active day4 HRF'
                % con_0061.nii = 'long unexp active day4 HRF'

                o = 1;
                for subjects = {'009', '011', '012', '013', '014', '015', '016', ...
                        '017', '019', '020', '022', '023', '024', '027', ...
                        '028', '029', '030', '031', '032', '033', '034', '035', ...
                        '037', '038', '039', '040', '041', '042', '043', '044', '045', ...
                        '046', '047', '053', '054'}
                    subject = char(subjects);

                    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(o).scans = ...
                        {
                        sprintf('%s/sub-%s/con_0003.nii',dirFirstlevel,subject) % SPM.xCon(3).name
                        sprintf('%s/sub-%s/con_0009.nii',dirFirstlevel,subject) % SPM.xCon(9).name
                        sprintf('%s/sub-%s/con_0055.nii',dirFirstlevel,subject) % SPM.xCon(55).name
                        sprintf('%s/sub-%s/con_0061.nii',dirFirstlevel,subject) % SPM.xCon(61).name
                        };

                    o = o +1;
                end

                % multi cov alternative
                if cov == "rt"
                    matlabbatch{1}.spm.stats.factorial_design.multi_cov.files = {...
                        sprintf('%s/covariates/RT_ses-004_cal_runwise_err_1s_ohne_sub036.txt',...
                        dirCode)};
                end

                % centering ?
                matlabbatch{1}.spm.stats.factorial_design.multi_cov.iCC = 1; % mean centering

                % run job
                spm_jobman('run', matlabbatch);

            end
        end
    end
end
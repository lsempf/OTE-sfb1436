% run 2nd level flexible factorial GLM
iDerivative = "hrf";
cov = "rt";
analysisName = 'flex_fact_RT_interaction'

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
                dirProjectRoot = '/data/projects/sfb_diract/scratch/sfb_diract';
                dirCode = '/data/projects/sfb_diract/scratch/sfb_diract/code/spm_second-level';

                %% grab names & type of contrasts from 1st level definition in spm_batch file
                % pick one SPM.mat file to extract contrast names
                % depending in chosen pipeline
                filenameSPMMat = sprintf('%s/derivatives/spm_first-level/%s/sub-001/SPM.mat',...     % zieht sich eine SPM.mat file und guckt
                    dirProjectRoot, modelName);

                %% dir firstlevel
                dirFirstlevel = sprintf('%s/derivatives/spm_first-level/s%g_glm_3_%s',...
                    dirProjectRoot,smoothing,time_lock);

                %%
                fprintf('running %s for %s\n',...
                    analysisName,modelName)

                % define where to put files
                dirOutput = sprintf('%s/derivatives/spm_second-level/%s/%s', ...
                    dirProjectRoot,modelName,analysisName);

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
                % model with only hrf / with 3 parameters
                o = 1;
                for subjects = {'001', '002', '004', '005', '006', '007', '008', ...
                        '009', '010', '011', '012', '013', '014', '015', '016', ...
                        '018'}
                    subject = char(subjects);

                    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(o).scans = ...
                        {
                        sprintf('%s/sub-%s/con_0001.nii',dirFirstlevel,subject) % SE SPM.xCon(1).name
                        sprintf('%s/sub-%s/con_0003.nii',dirFirstlevel,subject) % SU SPM.xCon(3).name
                        sprintf('%s/sub-%s/con_0011.nii',dirFirstlevel,subject) % LE SPM.xCon(11).name
                        sprintf('%s/sub-%s/con_0013.nii',dirFirstlevel,subject) % LU SPM.xCon(13).name
                        };

                    o = o +1;
                end

                % multi cov alternative
                if cov == "rt"
                    matlabbatch{1}.spm.stats.factorial_design.multi_cov.files = {...
                        sprintf('%s/covariates/RT_ses001_err_1s_session.txt',...
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
% create first level contrast 

% calculate first-level contrasts (definition of which is in
% `Generate_FirstLevelContrastBatch.m`)
%
% The referenced glm models all three iterations of the task (day 1
% passive, day 4  passive & active) in one single 1st level GLM

pipeline = 'fmriprep'
tmod = 0; % no tmod
iFirstLevel = "firstlevel";

%% start contrast manager script 

% all subjects 
subjects = {'009', '011', '012', '013', '014', '015', '016', ...
    '017', '019', '020', '022', '023', '024', '027', ...
    '028', '029', '030', '031', '032', '033', '034', '035', ...
    '037', '038', '039', '040', '041', '042', '043', '044', '045', ...
    '046', '047', '053', '054'};

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
            
            dirProjectRoot= '/home/data/sfb_cuetarget/analysis';
           
            filenameSPMMat = sprintf('%s/glm_analysis_fmriprep/%s/%s/sub-%s/SPM.mat',...
                dirProjectRoot,modelName,iFirstLevel,subject)
            
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

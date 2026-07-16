function run_convertfmriprep2spm(subject, dirData)


% define working dir as relative to this scripts location
dir_me = fileparts(mfilename('fullpath')) % I dont understand this

% make sure output folder exists
[~,~,~]=mkdir(dirData);

tasks = {'active'};
runs = 1:4;
sessions = [1];

for session = sessions
    for task = tasks
        task = cell2mat(task);
        for run = runs

            dirOutputFull = sprintf('%s/sub-%s/ses-%03i/func',...
                dirData,subject,session);
            [~,~,~] = mkdir(dirOutputFull);

            % load data
            file_name = sprintf('%s/sub-%s_ses-%03i_task-%s_run-%i_desc-confounds_timeseries.tsv',...
                dirOutputFull,subject,session,task,run);

            file = tdfread(file_name);
                % use readtable(), readmatrix(), readcell()

            % get 6 realigment parameters
            rp_file = [file.trans_x file.trans_y file.trans_z ...
                file.rot_x file.rot_y file.rot_z];

            % save data
            file_name = sprintf('%s/rp_sub-%s_ses-%03i_task-%s_run-%i_bold.txt',...
                dirOutputFull,subject,session,task,run);

            dlmwrite(file_name, rp_file)
        end
    end
end


end

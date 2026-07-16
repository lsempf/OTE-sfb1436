function matlabbatch = Generate_FirstLevelContrastBatch(filenameSPM)
% Script works for first level glms with 3 derivatives in the first level
% GLM

% ceate matlab batch
matlabbatch={};

% add SPM.mat file
matlabbatch{1}.spm.stats.con.spmmat = {filenameSPM};

% figure out how many "regressors" 
load(filenameSPM) 
nSessions  = numel(SPM.Sess); 
for iSession = nSessions:-1:1
    nRegressors(iSession)  =  numel(SPM.Sess(iSession).C.name);
end

nConditions = repmat(12,1,nSessions);

nTotal = sum(nConditions) + sum(nRegressors); 

nPrevious = [0 cumsum(nConditions)+cumsum(nRegressors)];

nPrevious = nPrevious(1:(end-1)); 

nRegressors = [nRegressors 0];

%% define short expected - for each task separately (HRF)
% this contrasts is an implicit baseline (short expected)
c = [0 0 0 0 0 0 1 0 0 0 0 0];

%%%%%
nextCon = 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 HRF';
startingSession = 1; % for passive session 1
con = []; % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session



%% define short expected - for each task separately (TEMP)
% this contrasts is an implicit baseline
c = [0 0 0 0 0 0 0 1 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session


%% define short unexpected - for each task separately (HRF)
c = [0 0 0 0 0 0 0 0 0 1 0 0]; % short unexpected (HRF)
%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
%% define short unexpecte - for each task separately (TEMP)
c = [0 0 0 0 0 0 0 0 0 0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define order of short expected minus short unexpected`(HRF)
c = [0 0 0 0 0 0 1 0 0 -1 0 0];

%%%%%
% TE effect in session 1 active
% original name: exp-unexp short naive or exp-unexp short passive one naive
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';



%%%%%%%%%ed
%% define order of short expected minus short unexpected (TEMP)
c = [0 0 0 0 0 0 0 1 0 0 -1 0];

%%%%%
% TE effect in session 1 passive
% original name: exp-unexp short naive or exp-unexp short passive one naive
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% Mean short vs baseline (HRF)
% beide short conditions zusammen betrachtet; über ALLE sessions.
c = [0 0 0 0 0 0 1 0 0 1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%%%
%% Mean short vs baseline (TEMP)
c = [0 0 0 0 0 0 0 1 0 0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% long stimulus (HRF)
d = [1 0 0 -1 0 0 0 0 0 0 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
%% long expected - long unexpected (TEMP)
d = [0 1 0 0 -1 0 0 0 0 0 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%% define long expected - for each task separately (HRF)
c = [1 0 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
%% define long expected - for each task separately (TEMP)
c = [0 1 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%% define long unexpected - for each task separately (HRF)
c = [0 0 0 1 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
%% define long unexpected - for each task separately (TEMP)
c = [0 0 0 0 1 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short expected - HRF
% this contrasts is an implicit baseline (short expected)
c = [0 0 0 0 0 0 1 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;

matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-1 HRF';
startingSession = 1; % for passive session 1
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';




%% define short expected - TMP
c = [0 0 0 0 0 0 0 1 0 0 0 0];
%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short unexpected - HRF
c = [0 0 0 0 0 0 0 0 0 1 0 0]; % short unexpected (HRF)

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short unexpected - TEMP
c = [0 0 0 0 0 0 0 0 0 0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';




%% define long expected - HRF
c = [1 0 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';




%% define long expected - TEMP
c = [0 1 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';




%% define long unexpected  (HRF)
c = [0 0 0 1 0 0 0 0 0 0 0 0];
%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define long unexpected - for each task separately (TEMP)
c = [0 0 0 0 1 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';





%% TE effects per run
%%%%%
c = [0 0 0    0 0 0    1 0 0     -1 0 0];

% TE passive naive run-1 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-2 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-3 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-4 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
c = [0 0 0    0 0 0    0 1 0     0 -1 0];

% TE passive naive run-1 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-1 TD';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-2 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-2 TD';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-3 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-3 TD';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-4 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day1 run-4 TD';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
c = [1 0 0    -1 0 0    1 0 0     -1 0 0];

% TE passive naive run-1 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp - unexp active day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-2 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp - unexp active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-3 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp - unexp active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-4 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp - unexp active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% Mean short vs baseline (HRF)
c = [0 0 0   0 0 0   1 0 0   1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%%%
%% Mean short vs baseline (TEMP)
c = [0 0 0   0 0 0   0 1 0   0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day1 TEMP';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% Mean long vs baseline (HRF)
c = [1 0 0   1 0 0   0 0 0   0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean long active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%%%
%% Mean long vs baseline (TEMP)
c = [0 1 0   0 1 0   0 0 0   0 0 0];

%%%%%
% beide short conditions zusammen betrachtet in active day4
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean long active day1 TEMP';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% Mean both delays vs baseline (HRF)
c = [1 0 0   1 0 0   1 0 0   1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean both delays active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%%%
%% Mean both delays vs baseline (TEMP)
c = [0 1 0   0 1 0   0 1 0   0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean both delays active day1 TEMP';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%%%
c = [-1 0 0   1 0 0     1 0 0   -1 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context active day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; % tcon.sessrep = repeat it for every session

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';




%% likely (averaged over delay)
c = [1 0 0   0 0 0     1 0 0   0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% unlikely active trained hrf
c = [0 0 0   1 0 0     0 0 0   1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% likely > unlikely (both delays) HRF
c = [1 0 0   -1 0 0     1 0 0   -1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.delete = 1;

end

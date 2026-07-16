function matlabbatch = Generate_FirstLevelContrastBatch(filenameSPM) 

matlabbatch={};

matlabbatch{1}.spm.stats.con.spmmat = {filenameSPM};

%% figure out how many "regressors" (i.e. not convolved wit HRF) there were per session
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
c = [0 0 0 0 0 0 1 0 0 0 0 0];

%%%%%
nextCon = 1;

matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 HRF';
startingSession = 1; 
con = []; % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 HRF';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 HRF';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short expected - for each task separately (TEMP)
c = [0 0 0 0 0 0 0 1 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 TEMP';
startingSession = 1; 
con = []; 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 TEMP';
startingSession = 5;
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 TEMP';
startingSession = 9;
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%% define short unexpected - for each task separately (HRF)
c = [0 0 0 0 0 0 0 0 0 1 0 0]; 
%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 HRF';
startingSession = 5;
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 HRF';
startingSession = 9;                                     
con = zeros(1,nPrevious(startingSession));          
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
%% define short unexpecte - for each task separately (TEMP)
c = [0 0 0 0 0 0 0 0 0 0 1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 TEMP';
startingSession = 9;                                             
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%% define order of short expected minus short unexpected`(HRF)
c = [0 0 0 0 0 0 1 0 0 -1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1; 
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short active day4 HRF';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3 
    con = [con c zeros(1,nRegressors(iRun+startingSession))]; 
end 
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short allSessions HRF';
con = [];
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4 HRF';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 and day4 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end 
con = con(1:end-72);
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4 and active day4 HRF';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:7; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%%%%%
%% define order of short expected minus short unexpected (TEMP)
c = [0 0 0 0 0 0 0 1 0 0 -1 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short active day4 TEMP';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3;  
    con = [con c zeros(1,nRegressors(iRun+startingSession))]; 
end 
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short allSessions TEMP';
con = [];
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 TEMP';
startingSession = 1;
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 and day4 TEMP';
startingSession = 1;
con = zeros(1,nPrevious(startingSession)); 
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end 

con = con(1:end-72);
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4 and active day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:7; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define task-version differences of unexpected-expected
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
currentNames = CollectAllConNames(matlabbatch);
indexNaive = ismember(currentNames, 'exp-unexp short passive day1 HRF'); 
indexTrained = ismember(currentNames,'exp-unexp short passive day4 HRF');   
indexTask = ismember(currentNames, 'exp-unexp short active day4 HRF');

%%%%%
% TE effect in passive day 1 - passive day 4 
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1-passive day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaive}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTrained}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
% TE effect in passive session 4 (trained) - active 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4-active day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexTrained}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTask}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1-active day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaive}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTask}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
% TE Effect in both passive sessions VS. active 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 and day4-active day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = (matlabbatch{1}.spm.stats.con.consess{indexNaive}.tcon.weights + matlabbatch{1}.spm.stats.con.consess{indexTrained}.tcon.weights) - 2*(matlabbatch{1}.spm.stats.con.consess{indexTask}.tcon.weights);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%%%%
%% define task-version differences of unexpected-expected
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
currentNames = CollectAllConNames(matlabbatch);
indexNaiveTEMP = ismember(currentNames, 'exp-unexp short passive day1 TEMP');    
indexTrainedTEMP = ismember(currentNames,'exp-unexp short passive day4 TEMP'); 
indexTaskTEMP = ismember(currentNames, 'exp-unexp short active day4 TEMP');

%%%%%
% TE effect in passive day 1 - passive day 4 
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1-passive day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaiveTEMP}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTrainedTEMP}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
% TE effect in passive session 4 (trained) - active 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day4-active day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexTrainedTEMP}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTaskTEMP}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1-active day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaiveTEMP}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTaskTEMP}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
% TE Effect in both passive sessions VS. active 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp short passive day1 and day4-active day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = (matlabbatch{1}.spm.stats.con.consess{indexNaiveTEMP}.tcon.weights + matlabbatch{1}.spm.stats.con.consess{indexTrainedTEMP}.tcon.weights) - 2*(matlabbatch{1}.spm.stats.con.consess{indexTaskTEMP}.tcon.weights);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% Mean short vs baseline (HRF)
c = [0 0 0 0 0 0 1 0 0 1 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short allSessions HRF';
con = [];
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short passive day1 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short passive day4 HRF';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day4 HRF';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%%%
%% Mean short vs baseline (TEMP)
c = [0 0 0 0 0 0 0 1 0 0 1 0];
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short allSessions TEMP';
con = [];
for iSession=1:nSessions
    con = [con c zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short passive day1 TEMP';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short passive day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day4 TEMP';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% long stimulus (HRF)
d = [1 0 0 -1 0 0 0 0 0 0 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day1 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day4 HRF';
startingSession = 5;
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long active day4 HRF';
startingSession = 9;
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3 
    con = [con d zeros(1,nRegressors(iRun+startingSession))]; 
end 
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long allSessions HRF';
con = [];
for iSession=1:nSessions
    con = [con d zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
currentNames = CollectAllConNames(matlabbatch);
indexNaiveL = ismember(currentNames, 'exp-unexp long passive day1 HRF');    
indexTrainedL = ismember(currentNames,'exp-unexp long passive day4 HRF'); 
indexTaskL = ismember(currentNames, 'exp-unexp long active day4 HRF');

matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day1-passive day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaiveL}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTrainedL}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day4-active day4 HRF';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexTrainedL}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTaskL}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
%% long expected - long unexpected (TEMP)
d = [0 1 0 0 -1 0 0 0 0 0 0 0];

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day1 TEMP';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con d zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long active day4 TEMP';
startingSession = 9; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3 
    con = [con d zeros(1,nRegressors(iRun+startingSession))]; 
end 
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% 
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long allSessions TEMP';
con = [];
for iSession=1:nSessions
    con = [con d zeros(1,nRegressors(iSession))];
end
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
currentNames = CollectAllConNames(matlabbatch);
indexNaiveL = ismember(currentNames, 'exp-unexp long passive day1 TEMP');    
indexTrainedL = ismember(currentNames,'exp-unexp long passive day4 TEMP'); 
indexTaskL = ismember(currentNames, 'exp-unexp long active day4 TEMP');

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day1-passive day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexNaiveL}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTrainedL}.tcon.weights;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';
% 

nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'exp-unexp long passive day4-active day4 TEMP';
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = matlabbatch{1}.spm.stats.con.consess{indexTrainedL}.tcon.weights - matlabbatch{1}.spm.stats.con.consess{indexTaskL}.tcon.weights; 
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define long expected - for each task separately (HRF)
c = [1 0 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 HRF';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 HRF';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 HRF';
startingSession = 9;                                           
con = zeros(1,nPrevious(startingSession));                 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
%% define long expected - for each task separately (TEMP)
c = [0 1 0 0 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 TEMP';
startingSession = 1; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 TEMP';
startingSession = 5; 
con = zeros(1,nPrevious(startingSession)); 
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 TEMP';
startingSession = 9;                                           
con = zeros(1,nPrevious(startingSession));                  
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; 
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define long unexpected - for each task separately (HRF)
c = [0 0 0 1 0 0 0 0 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 HRF';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 HRF';
startingSession = 5;
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 HRF';
startingSession = 9; % for task                                             
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 TEMP';
startingSession = 1; % for naive
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 TEMP';
startingSession = 5;
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 TEMP';
startingSession = 9; % for task                                            
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

matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-1 HRF';
startingSession = 1; % for passive session 1
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-1 HRF';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-2 HRF';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-3 HRF';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-4 HRF';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-4 HRF';
startingSession = 12; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short expected - TMP
% this contrasts is an implicit baseline (short expected)
c = [0 0 0 0 0 0 0 1 0 0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-1 TEMP';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-2 TEMP';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-3 TEMP';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp passive day4 run-4 TEMP';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-1 TEMP';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-2 TEMP';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-3 TEMP';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp active day4 run-4 TEMP';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-1 HRF';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-2 HRF';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-3 HRF';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-4 HRF';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-4 HRF';
startingSession = 12; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%% define short unexpected - TEMP
c = [0 0 0 0 0 0 0 0 0 0 1 0]; % short unexpected tmp

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-1 TEMP';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-2 TEMP';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-3 TEMP';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp passive day4 run-4 TEMP';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-1 TEMP';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-2 TEMP';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-3 TEMP';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short unexp active day4 run-4 TEMP';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-1 HRF';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-2 HRF';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-3 HRF';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-4 HRF';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-4 HRF';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-1 TEMP';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-2 TEMP';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-3 TEMP';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp passive day4 run-4 TEMP';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-1 TEMP';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-2 TEMP';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-3 TEMP';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long exp active day4 run-4 TEMP';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-1 HRF';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-2 HRF';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-3 HRF';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-4 HRF';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-4 HRF';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-1 TEMP';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-2 TEMP';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-3 TEMP';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day1 run-4 TEMP';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-1 TEMP';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-2 TEMP';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-3 TEMP';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp passive day4 run-4 TEMP';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-1 TEMP';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-2 TEMP';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-3 TEMP';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'long unexp active day4 run-4 TEMP';
startingSession = 12; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
c = [0 0 0    0 0 0    1 0 0     -1 0 0];

% TE passive naive run-1 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-1 HRF';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-2 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-3 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-4 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-4 HRF';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-1 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-1 HRF';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-2 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-2 HRF';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-3 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-3 HRF';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-4 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-4 HRF';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-1 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-2 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-3 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-4 HRF
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-4 HRF';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-1 TD';
startingSession = 1; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-2 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-2 TD';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-3 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-3 TD';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive naive run-4 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day1 run-4 TD';
startingSession = 4; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-1 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-1 TD';
startingSession = 5; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-2 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-2 TD';
startingSession = 6; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-3 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-3 TD';
startingSession = 7; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE passive trained run-4 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp passive day4 run-4 TD';
startingSession = 8; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-1 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-1 TD';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-2 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-2 TD';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-3 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-3 TD';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

% TE active trained run-4 TD
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'short exp - unexp active day4 run-4 TD';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day4 HRF';
startingSession = 9; % for task
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
% beide short conditions zusammen betrachtet in active day4
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean short active day4 TEMP';
startingSession = 9; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';



%% Mean long vs baseline (HRF)
% beide short conditions zusammen betrachtet; über ALLE sessions. 
c = [1 0 0   1 0 0   0 0 0   0 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean long active day4 HRF';
startingSession = 9; % for task
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean long active day4 TEMP';
startingSession = 9; % for task
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean both delays active day4 HRF';
startingSession = 9; % for task
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'mean both delays active day4 TEMP';
startingSession = 9; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';



%%%%%%%
%% context auf hrf in passive naive 
c = [-1 0 0   1 0 0     1 0 0   -1 0 0];

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context passive day1 HRF';
startingSession = 1; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context passive day1 run-1 HRF';
startingSession = 1; % for naive
con = []; % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none'; 

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context passive day1 run-2 HRF';
startingSession = 2; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context passive day1 run-3 HRF';
startingSession = 3; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'context passive day1 run-4 HRF';
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day4 HRF';
startingSession = 9; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely active day4 run-4 HRF';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day4 HRF';
startingSession = 9; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'unlikely active day4 run-4 HRF';
startingSession = 12; %
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
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day4 HRF';
startingSession = 9; % for task
con = zeros(1,nPrevious(startingSession));
for iRun = 0:3; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))];
CheckContrasts(filenameSPM,con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day4 run-1 HRF';
startingSession = 9; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day4 run-2 HRF';
startingSession = 10; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day4 run-3 HRF';
startingSession = 11; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';

%%%%%
nextCon = length(matlabbatch{1}.spm.stats.con.consess) + 1;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.name = 'likely > unlikely active day4 run-4 HRF';
startingSession = 12; %
con = zeros(1,nPrevious(startingSession)); % prepend zeros
for iRun = 1:1; con = [con c zeros(1,nRegressors(iRun+startingSession))]; end
con = [con zeros(1,nTotal-length(con))]; % append zeros
CheckContrasts(filenameSPM, con);
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.weights = con;
matlabbatch{1}.spm.stats.con.consess{nextCon}.tcon.sessrep = 'none';


matlabbatch{1}.spm.stats.con.delete = 1;

end



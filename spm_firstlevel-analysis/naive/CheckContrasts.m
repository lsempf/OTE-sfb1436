function CheckContrasts(filenameSPMMat, contrastVector, fid)
% This function inspects the provided SPM.mat file and prints the "product"
% of the regressors names in the design matrix and the contrasts.
% check if generated contrasts are correct 

assert(exist(filenameSPMMat,'file')==2, 'SPM file not found - check file %s truly exists', filenameSPMMat);
load(filenameSPMMat) % loads object `SPM`

if ~exist('fid','var')
    fid = 1;
end

% if no contrasts provided, loop over all cons defined in SPM.mat
if ~exist('contrastVector','var') || isempty(contrastVector) 
    nContrasts = length(SPM.xCon);
    fprintf(fid,'Nr of contrasts: %i\n', nContrasts);
    
    for iCon = 1:nContrasts
        fprintf(fid,'Contrast %i (Stat: %s) - name %s:\n',iCon, SPM.xCon(iCon).STAT,SPM.xCon(iCon).name);
        fprintf(fid,'-------------\n');
        
        switch SPM.xCon(iCon).STAT
            case 'F'
                % for F-contrasts plot contrast matrix
                figure(iCon)
                imagesc(SPM.xCon(iCon).c')
                colormap('gray')
                colorbar
                xlabel 'regressors'
                
            case 'T'
                
                involvedColumns = abs(SPM.xCon(iCon).c) > 0 ;
                columnNames = SPM.xX.name(involvedColumns);
                contrastMultipliers = SPM.xCon(iCon).c(involvedColumns);
                
                for iColumn = 1:numel(columnNames )
                    fprintf(fid,'% 5g * %s\n', contrastMultipliers(iColumn),columnNames{iColumn});
                end
        end
    end
    
else % if `contrasts` provided, spell that one one
    
    involvedColumns =  abs(contrastVector) > 0;
    columnNames = SPM.xX.name(involvedColumns);
    contrastMultipliers = contrastVector(involvedColumns);
    
    for iColumn = 1:numel(columnNames)
        fprintf(fid,'% 5g * %s\n', contrastMultipliers(iColumn),columnNames{iColumn}); % 5g = kürze so weit wie möglich zahl
    end                                                                                % 5 Leerzeichen 
                                                                                       % column name  
end                                                                                    % contrast wert * name of condition! 
                                                                                       % -1            * shortExpected 
                                                                                       % etc 

end
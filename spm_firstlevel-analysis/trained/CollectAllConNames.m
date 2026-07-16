
function names = CollectAllConNames(matlabbatch)
nCons = length(matlabbatch{1}.spm.stats.con.consess);
for i = nCons:-1:1
    contype = fieldnames(matlabbatch{1}.spm.stats.con.consess{i}); 
    contype = contype{1};
    switch contype
        case 'fcon'
            names{i} = matlabbatch{1}.spm.stats.con.consess{i}.fcon.name; 
        case 'tcon'
            names{i} = matlabbatch{1}.spm.stats.con.consess{i}.tcon.name; 
    end
end
end
% matlab batch from GUI 
% each condition has its own onsets/ duration

% -------------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_spec.dir = {'/Users/lindasempf/Documents/Promotion/filesFromMedusa/glm_analysis/results/s6_glm_combined/firstlevel/sub-009'};

%% timing 
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 66;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 33;

%% session 1
matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = { };
% 1 condition 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).onset = [ ]; % 37 or 13 placeholder? 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).orth = 1;

% 2 condition: 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).orth = 1;

% 3 condition:
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).orth = 1;

% 4 condition:
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).orth = 1;
 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {}); 
matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;

%% session 2 
matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 128;

%% session 3
matlabbatch{1}.spm.stats.fmri_spec.sess(3).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(3).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(3).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(3).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(3).hpf = 128;

%% session 4
matlabbatch{1}.spm.stats.fmri_spec.sess(4).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(4).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(4).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(4).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(4).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(4).hpf = 128;

%% session 5
matlabbatch{1}.spm.stats.fmri_spec.sess(5).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(5).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(5).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(5).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(5).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(5).hpf = 128;

%% session 6
matlabbatch{1}.spm.stats.fmri_spec.sess(6).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(6).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(6).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(6).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(6).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(6).hpf = 128;

%% session 7
matlabbatch{1}.spm.stats.fmri_spec.sess(7).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(7).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(7).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(7).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(7).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(7).hpf = 128;

%% session 8
matlabbatch{1}.spm.stats.fmri_spec.sess(8).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(8).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(8).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(8).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(8).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(8).hpf = 128;

%% session 9
matlabbatch{1}.spm.stats.fmri_spec.sess(9).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(9).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(9).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(9).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(9).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(9).hpf = 128;

%% session 10
matlabbatch{1}.spm.stats.fmri_spec.sess(10).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(10).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(10).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(10).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(10).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(10).hpf = 128;

%% session 11
matlabbatch{1}.spm.stats.fmri_spec.sess(11).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(11).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(11).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(11).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(11).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(11).hpf = 128;

%% session 12
matlabbatch{1}.spm.stats.fmri_spec.sess(12).scans = { };
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).name = 'LongExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).name = 'LongUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).name = 'ShortExpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(3).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).name = 'ShortUnexpected';
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).onset = [ ];
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).duration = 0.1;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(12).cond(4).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess(12).multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(12).regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess(12).multi_reg = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess(12).hpf = 128;

%% rest von model specification 
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [1 1];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

% -------------------------------------------------------------------------
%% ESTIMATE 
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
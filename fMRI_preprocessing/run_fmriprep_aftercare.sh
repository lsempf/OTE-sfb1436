#!/bin/bash

# this script uses the fmriprep output file from each subject individually
# and performs additional preprocessing steps not implemented in fmriprep
#
# (1) gunzip the data and rsync it into scratch
# (2) remove dummy scans
# (3) smooth (8mm) func epis data
# (4) smooth (8mm) GM and WM segments

# Input : subjectID (e.g. 002)

# process input
# ------------------------------------------------------------------------------
echo "starting preprocessing script - setting variables"
subject=$1

# Settings
# ------------------------------------------------------------------------------
# project name - will be used for directory on scratch
projectName=fmriprep_aftercare

# directory where project data resides
dirProject=/data/projects/sfb_diract/scratch/sfb_diract
# directory for temporary calculations
dirScratch=/data/projects/sfb_diract/scratch/sfb_diract/scratch/"$projectName"

# directory for derivatives.
dirDerivatives=$dirProject/derivatives/fmriprep_preproc

# directory for final derivatives - smoothed func images and smoothed
# segmentations will be written here
dirFinalOutput=$dirProject/derivatives/fmriprep_preproc

echo "dirDerivatives is:"
echo $dirDerivatives

echo "dirFinalOutput is:"
echo $dirFinalOutput

# number of volumes to remove´(2Vol*2s = 4s; 4s are removed from mat file in tsv2onsetsMat_cue.m and tsv2onsetsMat_target.m)
nVolsRemove=0

# directory where matlab's preprocessing script is located
dirCode=$dirProject/code/fmriprep_preproc/fmriprep-aftercare_slurm

# Smoothing
# ------------------------------------------------------------------------------
# decide wheter smoothing should be applied
smoothkernel=8

echo "smoothing kernel is:"
echo $smoothkernel

echo "done with setting variables"

# Gunzipping in derivatives/fmriprep
# ------------------------------------------------------------------------------
echo "beginning with gunzip relevant images of both sessions in derivatives"

gunzip -k "$dirDerivatives"/sub-"$subject"/ses-001/anat/*MNI*GM*.nii.gz
gunzip -k "$dirDerivatives"/sub-"$subject"/ses-001/anat/*MNI*WM*.nii.gz
gunzip -k "$dirDerivatives"/sub-"$subject"/ses-001/anat/*space-MNI152NLin2009cAsym_desc-preproc_T1w.nii.gz

gunzip -k "$dirDerivatives"/sub-"$subject"/ses-001/func/*task-active_run-*_space-MNI*preproc_bold.nii.gz

echo "done with: gunzip"


# Step 1: Copy niftis into scratch folder
# ------------------------------------------------------------------------------
echo "----------------------------------------------------------------------------"
echo `date` " -- copying files into scratch folder"
echo "----------------------------------------------------------------------------"

dirSubject="$dirScratch"/sub-"$subject"

# create subfolders for each session for relevant niftis
mkdir -p $dirSubject
mkdir -p $dirSubject/ses-001/anat
mkdir -p $dirSubject/ses-001/func

# rsync anatomical images manually (for VBM)
rsync -acv "$dirDerivatives"/sub-"$subject"/ses-001/anat/*MNI*GM*.nii\
            $dirSubject/ses-001/anat/
rsync -acv "$dirDerivatives"/sub-"$subject"/ses-001/anat/*MNI*WM*.nii\
            $dirSubject/ses-001/anat/

# rsync relevant parts from derivatives/fmriprep/
pushd $dirCode/utils
matlab -nodisplay -nodesktop -noFigureWindows -singleCompThread\
   -r run_convert4Dto3D_fmriprep\(\'"$subject"\',\'"$dirDerivatives"\',\'"$dirScratch"\'\)\;quit
popd # return to original dir

# Step 3: Smoothing of func images and anat segments
#-------------------------------------------------------------------------------
echo "----------------------------------------------------------------------------"
echo `date` " -- smoothing of func epis and GM / WM segments"
echo "----------------------------------------------------------------------------"
pushd $dirCode/utils
matlab -nodisplay -nodesktop -noFigureWindows -singleCompThread\
  -r run_smoothing\(\'"$subject"\',\'"$dirScratch"\',\'"$smoothkernel"\'\)\;quit
popd

# Step 4: convert func images back to 4D images
#-------------------------------------------------------------------------------
pushd $dirCode/utils # must run matlab from within $dirCode..
matlab -nodisplay -nodesktop -noFigureWindows -singleCompThread\
   -r run_3Dto4D_fmriprep\(\'"$subject"\',\'"$smoothkernel"\',\'"$dirScratch"\'\,\'"$dirDerivatives"\'\)\;quit
popd

# copy anatomical images
mkdir -p $dirDerivatives/sub-$subject/ses-001/anat
rsync -acv $dirSubject/ses-001/anat/s*sub* $dirDerivatives/sub-$subject/ses-001/anat


# Step 5: Create realignment file for SPM's first level analysis
#-------------------------------------------------------------------------------
echo "----------------------------------------------------------------------------"
echo `date` " -- creating realignment file"
echo "----------------------------------------------------------------------------"

rsync -acv "$dirDerivatives"/sub-"$subject"/ses-001/func/sub-"$subject"_ses-001_task-active_run-*_desc-confounds_timeseries.tsv\
            $dirSubject/ses-001/func/

pushd $dirCode/utils
matlab -nodisplay -nodesktop -noFigureWindows -singleCompThread\
   -r run_convertfmriprep2spm\(\'"$subject"\',\'"$dirScratch"\'\)\;quit
popd # return to original dir

# rsync realignment files into derivatives/fmriprep
rsync -acv $dirSubject/ses-001/func/rp_sub-*_ses-001_task-*_run-*_bold.txt\
          "$dirDerivatives"/sub-"$subject"/ses-001/func/


# Step 6: delete subject folder under scratch
#-------------------------------------------------------------------------------
echo "----------------------------------------------------------------------------"
echo `date` " -- deleting subject folder under dirScratch"
echo "----------------------------------------------------------------------------"

#dirSubjectDelete="$dirScratch"/sub-"$subject"
rm -rf  $dirSubjectDelete

echo "----------------------------------------------------------------------------"
echo `date` " -- finished complete processing of $subject"
echo "----------------------------------------------------------------------------"

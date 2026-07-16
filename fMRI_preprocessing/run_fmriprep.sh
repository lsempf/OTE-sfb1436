#!/bin/bash

subject=$1

req_cpu=10

req_ram=20000

project_root=/data/projects/sfb_diract/scratch/sfb_diract/
dir_output=${project_root}derivatives/fmriprep_preproc/
dir_work_root=${project_root}scratch/fmriprep/
dir_bids=${project_root}rawdata

dir_work=$(mktemp -d -p $dir_work_root)

fmriprep \
    --fs-license-file /data/projects/sfb_diract/scratch/sfb_diract/code/fmriprep_preproc/fmriprep_slurm/freesurfer_license.txt \
    --nprocs $req_cpu \
    --mem $req_ram \
    --skip_bids_validation \
    --slice-time-ref 0.5 \
    --fs-no-reconall \
    --notrack \
    -vvv \
    $dir_bids \
    $dir_output \
    participant --participant-label $subject \
    --work $dir_work_root \

rm -rf $dir_work

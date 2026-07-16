#!/bin/bash

#SBATCH --mail-user=linda.sempf@ovgu.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --job-name=fmriprep
#SBATCH --cpus-per-task=10
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=4g
#SBATCH --time=24:00:00
####SBATCH --partition=<partition_name>
#SBATCH --output=slurm_logs/output-%A-%a.out
#SBATCH --error=slurm_logs/error-%A-%a.err
#SBATCH --array 0-15

idx=$((SLURM_ARRAY_TASK_ID)) # index to keep track of jobs

subjects=(001 002 004 005 006 007 008 009 010 011 012 013 014 015 016 018)

# Now simply call the script with the subject ID
./run_fmriprep.sh ${subjects[idx]}

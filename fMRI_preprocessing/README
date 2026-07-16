## fMRI Preprocessing

The preprocessing pipeline used for both the **naïve** and **trained** participant datasets is based on **fMRIPrep v21.1**.

### Running the preprocessing pipeline

#### Option 1: Systems with SLURM

If your computing environment uses SLURM, preprocessing can be started by submitting the array job:

`fmriprep_arrayjob.slurm`

This script automatically calls:

`run_fmriprep.sh`

#### Option 2: Systems without SLURM

If SLURM is not available, preprocessing can be performed by running

`run_fmriprep.sh`

individually for each participant.

### Post-processing

After fMRIPrep has finished, execute

`run_fmriprep_aftercare.sh`

per subject to perform the additional post-processing steps (e.g., spatial smoothing and other post-fMRIPrep processing required for the analyses).

### Input Data

The preprocessing pipeline requires the raw MRI data in **BIDS** format as input.

Due to storage limitations, the raw MRI dataset is currently **not** available via OSF. Researchers interested in accessing the de-identified BIDS dataset for non-commercial research purposes are invited to contact **Linda Sempf** at **[linda.sempf@ovgu.de](mailto:linda.sempf@ovgu.de)**, providing a brief rationale for their request. Access to the data will be granted upon review.

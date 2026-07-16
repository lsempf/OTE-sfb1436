## Second-Level Analysis

The group-level fMRI analyses were performed in **SPM12** using a **flexible factorial design**.

Separate second-level analyses were conducted for the **naïve** and **trained** participant datasets. Each model included the four experimental conditions of interest. In addition, condition-specific mean response times were included as covariates.

### Input Data

The second-level analyses require the first-level contrast images as input.

The complete set of contrast images for both the **naïve** and **trained** participant datasets is publicly available via OSF:

https://osf.io/am6y7/

The condition-specific mean response times used as covariates are also available from the same OSF repository.

### ROI-Based Comparison Between Trained and Naïve Participants

To directly compare the neural responses between trained and naïve participants, an additional ROI-based analysis was performed.

First, the MATLAB script `extract_mean_beta_weights.m` extracts the mean beta values from the contrast images of the trained participants using the ROIs identified in the second-level analyses. The same ROIs are then applied to the corresponding contrast images of the naïve participants.

The extracted mean beta values (`.csv` files) and all ROI files used for the extraction are included in this repository.

The R Markdown notebook `run_analysis.Rmd` performs all statistical analyses and generates the corresponding figures presented in the manuscript for the ROI comparison between trained and naïve participants.


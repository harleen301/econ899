# Data

This folder contains the data used in the analysis.

The data are organized into two sub folders:

- `raw_data/` contains the original data sources used to construct the analysis data sets. 
The original raw files are not included in the repository because of file size and distribution 
considerations. See `raw_data/README.md` for source information and download links.

- `data_for_analysis/` contains the cleaned and processed data sets used by the standard replication. 
These files are included in the repository so that the results can be reproduced without rerunning 
the computationally intensive spatial data-processing steps.

The standard replication begins from the processed files in `data_for_analysis/`. 
The programs used to construct these files from the original raw data are provided 
in `programs/01_dataprep/`.

See the README files in each sub folder for additional details.

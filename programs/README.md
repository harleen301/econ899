# Programs

This folder contains all R programs used for data preparation, analysis, and replication.

- `00_setup.R` installs the required R packages and creates the required project folders.
- `config.R` defines the repository paths and loads the required packages.
- `01_main.R` runs the complete standard replication.

Programs are organized into three sub folders:

- `01_dataprep/` contains programs used to construct the analysis datasets.
- `02_analysis/` contains programs used to generate the main tables and figure.
- `03_appendix/` contains programs used to generate the appendix robustness results.

The standard replication can be run by first running `00_setup.R` once and 
then running `01_main.R`. See the repository-level `README.md` for complete 
replication instructions.
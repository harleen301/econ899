# Wildfire Smoke and Student Achievement: Evidence from British Columbia
Harleen Kaur (August 2026)

## Overview

This repository contains the data, code, and replication materials for my MA research paper, 
*Wildfire Smoke and Student Achievement: Evidence from British Columbia*. The paper examines 
whether wildfire smoke exposure affects student achievement across British Columbia 
school districts between 2017 and 2024. I combine district-level Foundation Skills Assessment (FSA) 
numeracy outcomes with satellite-derived PM₂.₅ concentrations and geospatial information on wildfire
burned area. Student numeracy performance is standardized relative to the corresponding provincial 
mean and standard deviation for each grade and year. The empirical analysis uses a two-stage least 
squares (2SLS) instrumental variables approach in which nearby wildfire activity is used as an instrument 
for wildfire-season PM₂.₅ exposure. All specifications include school district and year fixed effects, 
with standard errors clustered at the school district level. The repository contains the processed data 
required to reproduce the analysis, the programs used to construct the analysis data sets, and the code 
required to reproduce all tables and figures reported in the paper.


## Data Availability and Provenance Statements


All data used in this paper were obtained from publicly available sources. The analysis combines three 
primary data sources:

1. **Foundation Skills Assessment (FSA)** data from the British Columbia Education Analytics Office.
This provides district-level numeracy outcomes for Grade 4 and Grade 7 students.

2. **National Burned Area Composite (NBAC)** data from Natural Resources Canada. 
This provides geospatial information on wildfire burned area and are used to construct measures
of wildfire activity surrounding each school district.

3. **Monthly PM₂.₅ concentration data** from the Atmospheric Composition Analysis Group (ACAG), 
Washington University in St. Louis. The satellite-derived data are provided at approximately 1 km 
spatial resolution and are used to construct district-level wildfire-season PM₂.₅ exposure.

The processed data sets required for the standard replication are included in:

`data/data_for_analysis/`

The original raw data sets are not included in the repository. They can be obtained from their 
respective public data providers. Programs documenting the construction of the processed data sets from the 
original sources are provided in:

`programs/01_dataprep/`

Because processing the monthly satellite PM₂.₅ raster files is computationally intensive, 
the standard replication begins from the processed data sets included with the repository.

### Statement about Rights

I certify that the author of the manuscript have legitimate access to and permission to use the data 
used in this manuscript. 

### Data Availability Summary

| Data | Source | Original Raw Data Provided | Processed Data Provided |
|---|---|---:|---:|
| Foundation Skills Assessment (FSA) | BC Education Analytics Office | No | Yes |
| National Burned Area Composite (NBAC) | Natural Resources Canada | No | Yes |
| Monthly PM₂.₅ concentrations | Atmospheric Composition Analysis Group (ACAG) | No | Yes |


### Processed Analysis Data

The `data/data_for_analysis/` directory contains the processed data sets required by the 
standard replication workflow. Key files include:

| File | Description |
|---|---|
| `final_panel.rds` | Final district-year-grade analysis panel using the baseline 50 km wildfire buffer |
| `final_panel.csv` | CSV version of the final baseline analysis panel |
| `final_panel_75km.rds` | Analysis panel used for the alternative 75 km wildfire-buffer specification |
| `final_panel_75km.csv` | CSV version of the 75 km analysis panel |
| `pm25_yearly.rds` | District-year average PM₂.₅ exposure for the May–September wildfire season |
| `pm25_monthly.rds` | District-month PM₂.₅ exposure estimates |
| `wildfire_yearly_50km.rds` | District-year wildfire activity measured within 50 km |
| `wildfire_yearly_75km.rds` | District-year wildfire activity measured within 75 km |
| `fsa_num.rds` | Cleaned district-level FSA numeracy data |
| `fsa_province_stats.rds` | Provincial FSA means and standard deviations used to construct standardized numeracy outcomes |
| `school_district_boundaries.rds` | Processed BC school district spatial boundaries |
| `nbac_bc_clean.rds` | Processed NBAC wildfire data for British Columbia |

Additional intermediate data sets used by the data-preparation programs are also included in this directory.


## Repository Structure

The replication package is organized as follows:

    econ899/
    |
    |-- programs/
    |   |-- 00_setup.R
    |   |-- config.R
    |   |-- 01_main.R
    |   |
    |   |-- 01_dataprep/
    |   |   |-- main.R
    |   |   |-- data preparation programs
    |   |
    |   |-- 02_analysis/
    |   |   |-- main.R
    |   |   |-- figure01.R
    |   |   |-- table01.R
    |   |   |-- table02.R
    |   |   |-- table03.R
    |   |
    |   |-- 03_appendix/
    |       |-- main.R
    |       |-- tableA1.R
    |       |-- tableA2.R
    |
    |-- data/
    |   |-- raw_data/
    |   |-- data_for_analysis/
    |
    |-- results/


## Software Requirements

The analysis was conducted in **R version 4.5.1** on Windows 11.

The replication package includes:

`programs/00_setup.R`

This program installs any missing R packages required by the project and creates the required  
project directories. It is intended to be run once before executing the replication.

The packages used in the project include:

- tidyverse
- sf
- terra
- exactextractr
- bcdata
- readxl
- lubridate
- patchwork
- scales
- fixest

Additional package dependencies are installed automatically when required packages are installed.
No pseudo-random number generation is used in the analysis. Results are therefore deterministic.


## Replication Instructions

The standard replication uses the processed data sets included in `data/data_for_analysis/`.


### Step 1: Configure the repository location

Open:

`programs/config.R`

and change `repo_root` to the location of the repository on the user's computer.

For example:

    repo_root <- "C:/Users/USERNAME/Documents/GitHub/econ899"

This is the only program that should require user-specific modification.


### Step 2: Run the setup program

Run:

`programs/00_setup.R`

This program installs any missing R packages and creates the required project directories.
The setup program only needs to be run once on a new system.


### Step 3: Run the main replication program

Run:

`programs/01_main.R`

This program calls the data preparation, main analysis, and appendix programs in the correct order.

Specifically, it runs:

1. `programs/01_dataprep/main.R`
2. `programs/02_analysis/main.R`
3. `programs/03_appendix/main.R`

No additional manual intervention is required once the main replication program has been launched.


## Runtime and Computational Requirements

The standard replication begins from the processed data sets included in `data/data_for_analysis/`. 
On the system used to develop and test the code, the complete standard replication takes less than one minute.
The analysis is designed to run on a standard desktop or laptop computer and does not require high-performance 
computing resources.

Reconstructing the processed PM₂.₅ data from the original monthly satellite raster files is significantly more 
computationally intensive and can require approximately 8–10 hours. The programs used for this processing are 
included in `programs/01_dataprep/` but are not executed by default in the standard replication.

Approximately 5–10 GB of available storage is recommended if the original raw PM₂.₅ files are downloaded and 
the processed data are reconstructed from scratch.


## Description of Programs


### `programs/00_setup.R`

Installs the R packages required by the project and creates the required project directories. 
This program is intended to be run once on a new system.


### `programs/config.R`

Defines the repository and sub folder locations and loads the packages required by the 
data-preparation and analysis programs. The repository location specified by `repo_root` 
is the only setting that a replicator should need to modify.


### `programs/01_main.R`

Master replication program. It calls the data-preparation, main-analysis, and appendix 
main programs in the correct order.


### `programs/01_dataprep/`

Contains the programs used to construct the analysis data sets.

The programs document:

- cleaning and preparing the Foundation Skills Assessment data
- processing monthly satellite-derived PM₂.₅ concentrations
- calculating district-level wildfire-season PM₂.₅ exposure
- processing NBAC wildfire data
- constructing wildfire exposure measures using 50 km and 75 km buffers
- constructing the final district-year-grade analysis panels

The standard `programs/01_dataprep/main.R` begins from the processed data supplied
in `data/data_for_analysis/` and rebuilds the final analysis panels.

The computationally intensive programs used to reconstruct the processed spatial 
data sets from the original raw data are retained in this directory but are 
commented out in the standard data-preparation workflow.


### `programs/02_analysis/`

Contains the programs used to reproduce the main tables and figure reported in the paper.

- `figure01.R` generates Figure 1.
- `table01.R` generates Table 1: Summary Statistics.
- `table02.R` generates Table 2: First-Stage Regression Results.
- `table03.R` generates Table 3: Main IV and OLS Results.

`programs/02_analysis/main.R` runs these programs in the required order.


### `programs/03_appendix/`

Contains the programs used to reproduce the appendix robustness checks.

- `tableA1.R` generates Appendix Table A1.
- `tableA2.R` generates Appendix Table A2.

`programs/03_appendix/main.R` runs both appendix programs.


## Tables and Figures

The standard replication reproduces all tables and figures reported in the paper.

| Figure/Table | Program | Output |
|---|---|---|
| Figure 1 | `programs/02_analysis/figure01.R` | `results/figure01_exposure_maps_2017_2024.png` |
| Table 1: Summary Statistics | `programs/02_analysis/table01.R` | `results/table01_summary_statistics.txt` |
| Table 2: First-Stage Results | `programs/02_analysis/table02.R` | `results/table02_first_stage.txt` |
| Table 3: Main IV and OLS Results | `programs/02_analysis/table03.R` | `results/table03_main_results.txt` |
| Appendix Table A1 | `programs/03_appendix/tableA1.R` | `results/tableA1_covid_robustness.txt` |
| Appendix Table A2 | `programs/03_appendix/tableA2.R` | `results/tableA2_buffer75km.txt` |

All generated outputs are written automatically to the `results/` directory.


## References


Canadian Forest Service (2026) “National Burned Area Composite (NBAC).” Natural Resources Canada. 
Available at: https://cwfis.cfs.nrcan.gc.ca/ (Accessed: June 6, 2026).

Education Analytics Office (2013) “BC Schools - Foundation Skills Assessment (FSA).”
https://catalogue.data.gov.bc.ca/dataset/bc-schools-foundation-skills-assessment-fsa- (Accessed: June 6, 2026).

Education Analytics Office (2008) “School Districts of BC.” 
https://catalogue.data.gov.bc.ca/dataset/school-districts-of-bc (Accessed: June 6, 2026).

Shen, S. et al. (2024) “Enhancing global estimation of fine particulate matter concentrations by 
including geophysical a priori information in deep learning,” ACS ES&T Air, 1(5), pp. 332–345.
https://doi.org/10.1021/acsestair.3c00054.


---
title: README for "The  Effect of Wildfire Smoke Exposure on Student Performance in Britsh Columbia"
contributors:
  - Harleen Kaur
version: July 15, 2026
---

## Overview

This repository contains the data, code, and replication materials for my MA research paper The Effect of Wildfire Smoke Exposure on Student Performance in British Columbia. The paper examines whether wildfire smoke exposure affects student numeracy performance across British Columbia school districts 
between 2017 and 2024. Wildfire smoke exposure is measured using satellite-derived PM₂.₅ concentrations and wildfire activity from the National Burned Area Composite (NBAC). Student achievement is measured using district-level Foundation Skills Assessment (FSA) numeracy scores. The empirical analysis
employs a two-stage least squares (2SLS) instrumental variables approach, using nearby wildfire activity as an instrument for wildfire-season PM₂.₅ exposure. The replication package contains scripts to construct the analysis dataset, estimate all models presented in the paper, and reproduce all tables 
and figures.

## Data Availability and Provenance Statements

All data used in this paper are obtained from publicly available sources. The analysis combines three datasets:

Foundation Skills Assessment (FSA) data obtained from the British Columbia Education Analytics Office.
Wildfire perimeter and burned area data obtained from the National Burned Area Composite (NBAC), Natural Resources Canada.
Monthly PM₂.₅ concentration data obtained from the Atmospheric Composition Analysis Group (ACAG), Washington University in St. Louis.

The replication package contains all code used to clean, merge, and analyze these datasets. Raw data files are stored in the data/raw_data directory, while cleaned analysis datasets are stored in data/data_for_analysis.

Researchers wishing to fully reproduce the analysis should obtain the original public datasets from their respective providers and place them in the appropriate data/raw_data folders before running the data preparation scripts.

### Statement about Rights

I certify that the author(s) of the manuscript have legitimate access to and permission to use the data used in this manuscript. 

### Summary of Availability

All data **are** publicly available.

The original datasets are publicly available from their respective providers but may be subject to their own distribution or licensing requirements. The replication package therefore includes the code necessary to reconstruct the analysis datasets from the publicly available sources.

#### Summary of Data Availability


| Data.Name | Data.Source | Provided | 
| -- | -- | -- | -- | -- | 
| “Foundation Skills Assessment (FSA)” | BC Education Analytics Office | NO (download from source) | 
| “National Burned Area Composite (NBAC)” | Natural Resources Canada | NO (download from source) |
| “Monthly PM₂.₅” | Atmospheric Composition Analysis Group (ACAG) | NO (download from source) |


### Details on each Data Source

> INSTRUCTIONS: For each data source, list the file that contains data from that source here; if providing combined/derived datafiles, list them separately after the DAS. For each data source or file, as appropriate, 
> 
> - Describe the format (open formats preferred, but some software-specific formats OK if open-source readers available): `.dta`, `.xlsx`, `.csv`, `netCDF`, etc.
> - Provide a data dictionary, either as part of the archive (list the file name), or at a URL (list the URL). Some formats are self-describing *if* they have the requisite information (e.g., `.dta` should have both variable and value labels).
> - List availability within the package
> - Use proper bibliographic references in addition to a verbose description (and provide a bibliography at the end of the README, expanding those references)
> - Describe how you obtained access to the data.
> - If different, describe how others can obtain access to the data. 
> - Mention any relevant restrictions: approximate cost, required residency, necessary physical location, access only from within country or through VPN, etc.



### Example for public use data collected by the authors

> The [DATA TYPE] data used to support the findings of this study have been deposited in the [NAME] repository ([DOI or OTHER PERSISTENT IDENTIFIER]). [[1](https://www.hindawi.com/research.data/#statement.templates)]. The data were collected by the authors, and are available under a Creative Commons Non-commercial license.

### Example for public use data sourced from elsewhere and provided

> Data on National Income and Product Accounts (NIPA) were downloaded from the U.S. Bureau of Economic Analysis (BEA, 2016). We use Table 30. Data can be downloaded from https://apps.bea.gov/regional/downloadzip.cfm, under "Personal Income (State and Local)", select CAINC30: Economic Profile by County, then download. Data can also be directly downloaded using  https://apps.bea.gov/regional/zip/CAINC30.zip. A copy of the data is provided as part of this archive. The data are in the public domain.

Datafile:  `CAINC30__ALL_AREAS_1969_2018.csv`

### Example for public use data with required registration and provided extract

> The paper uses IPUMS Terra data (Ruggles et al, 2018). IPUMS-Terra does not allow for redistribution, except for the purpose of replication archives. Permissions as per https://terra.ipums.org/citation have been obtained, and are documented within the "data/IPUMS-terra" folder.
>> Note: the reference to "Ruggles et al, 2018" would be resolved in the Reference section of this README, **and** in the main manuscript.

Datafile: `data/raw/ipums_terra_2018.dta`

### Example for free use data with required registration, extract not provided

> The paper uses data from the World Values Survey Wave 6 (Inglehart et al, 2019). Data is subject to a redistribution restriction, but can be freely downloaded from http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp. Choose `WV6_Data_Stata_v20180912`, fill out the registration form, including a brief description of the project, and agree to the conditions of use. Note: "the data files themselves are not redistributed" and other conditions. Save the file in the directory `data/raw`. 

>> Note: the reference to "Inglehart et al, 2018" would be resolved in the Reference section of this README, **and** in the main manuscript.

Datafile: `data/raw/WV6_Data_Stata_v20180912.dta` (not provided)

### Example for confidential data

> INSTRUCTIONS: Citing and describing confidential data, in particular when it does not have a regular distribution channel or online landing page, can be tricky. A citation can be crafted ([see guidance](https://social-science-data-editors.github.io/guidance/FAQ.html#data-citation-without-online-link)), and the DAS should describe how to access, whom to contact (including the role of the particular person, should that person retire), and other relevant information, such as required citizenship status or cost.

> The data for this project (DESE, 2019) are confidential, but may be obtained with Data Use Agreements with the Massachusetts Department of Elementary and Secondary Education (DESE). Researchers interested in access to the data may contact [NAME] at [EMAIL], also see www.doe.mass.edu/research/contact.html. It can take some months to negotiate data use agreements and gain access to the data. The author will assist with any reasonable replication attempts for two years following publication.

### Example for confidential Census Bureau data

> All the results in the paper use confidential microdata from the U.S. Census Bureau. To gain access to the Census microdata, follow the directions here on how to write a proposal for access to the data via a Federal Statistical Research Data Center: https://www.census.gov/ces/rdcresearch/howtoapply.html. 
You must request the following datasets in your proposal:
>1. Longitudinal Business Database (LBD), 2002 and 2007
>2. Foreign Trade Database – Import (IMP), 2002 and 2007
[...]

(adapted from [Fort (2016)](https://doi.org/10.1093/restud/rdw057))

### Example for preliminary code during the editorial process

> Code for data cleaning and analysis is provided as part of the replication package. It is available at https://dropbox.com/link/to/code/XYZ123ABC for review. It will be uploaded to the [JOURNAL REPOSITORY] once the paper has been conditionally accepted.

## Dataset list

> INSTRUCTIONS: In some cases, authors will provide one dataset (file) per data source, and the code to combine them. In others, in particular when data access might be restrictive, the replication package may only include derived/analysis data. Every file should be described. This can be provided as a Excel/CSV table, or in the table below.

> INSTRUCTIONS: While it is often most convenient to provide data in the native format of the software used to analyze and process the data, not all formats are "open" and can be read by other (free) software. Data should at a minimum be provided in formats that can be read by open-source software (R, Python, others), and ideally be provided in non-proprietary, archival-friendly formats. 

> INSTRUCTIONS: All data files should be fully documented: variables/columns should have labels (long-form meaningful names), and values should be explained. This might mean generating a codebook, pointing at a public codebook, or providing data in (non-proprietary) formats that allow for a rich description. This is in particular important for data that is not distributable.

> INSTRUCTIONS: Some journals require, and it is considered good practice, to provide synthetic or simulated data that has some of the key characteristics of the restricted-access data which are not provided. The level of fidelity may vary - it may be useful for debugging only, or it should allow to assess the key characteristics of the statistical/econometric procedure or the main conclusions of the paper.

| Data file | Source | Notes    |Provided |
|-----------|--------|----------|---------|
| `data/raw/lbd.dta` | LBD | Confidential | No |
| `data/raw/terra.dta` | IPUMS Terra | As per terms of use | Yes |
| `data/derived/regression_input.dta`| All listed | Combines multiple data sources, serves as input for Table 2, 3 and Figure 5. | Yes |


## Computational requirements

> INSTRUCTIONS: In general, the specific computer code used to generate the results in the article will be within the repository that also contains this README. However, other computational requirements - shared libraries or code packages, required software, specific computing hardware - may be important, and is always useful, for the goal of replication. Some example text follows. 

> INSTRUCTIONS: We strongly suggest providing setup scripts that install/set up the environment. Sample scripts for [Stata](https://github.com/gslab-econ/template/blob/master/config/config_stata.do),  [R](https://github.com/labordynamicsinstitute/paper-template/blob/master/programs/global-libraries.R), [Julia](https://github.com/labordynamicsinstitute/paper-template/blob/master/programs/packages.jl) are easy to set up and implement. Specific software may have more sophisticated tools: [Python](https://pip.pypa.io/en/stable/user_guide/#ensuring-repeatability), [Julia](https://julia.quantecon.org/more_julia/tools_editors.html#Package-Environments).

### Software Requirements

The analysis was conducted in R (version 4.5.1) using RStudio.

The replication package includes a setup script (00_setup.R) that installs all required R packages. 
This script should be run before executing any other programs.

The primary R packages used in the analysis include:

tidyverse
dplyr
sf
terra
exactextractr
bcdata
fixest
ggplot2
patchwork
lubridate
readxl
purrr

Additional package dependencies are installed automatically by 00_setup.R.

### Controlled Randomness

No pseudo-random number generation is used in the analysis.

All results are deterministic and can be reproduced by running the scripts in the order described in this README.

### Memory, Runtime, Storage Requirements

#### Summary time to reproduce

Two replication options are provided:

Replication Option
Full replication (beginning with raw PM₂.₅ raster files)	8–10 hours
Realistic replication (beginning with cleaned analysis datasets)	Less than 10 minutes

The majority of computation time is devoted to extracting district-level PM₂.₅ exposure from monthly satellite raster files. All subsequent data preparation, estimation, 
tables, and figures require only a few minutes.

#### Summary of required storage space

Approximately 5–10 GB of available storage is recommended to accommodate the raw datasets, intermediate files, and generated outputs.

#### Computational Details

The code was developed and tested using:

Operating System: Windows 11
R Version: 4.5.1
RStudio: (Update version if desired)

The analysis is designed to run on a standard desktop or laptop computer and does not require high-performance computing resources.

## Description of programs/code

The replication package is organized into four main folders: programs/, data/, results/, and paper/.

*programs/00_setup.R*

Installs all required R packages and creates the directory structure needed to run the replication package. This script should be run once on a new system before 
executing any other programs.

*programs/01_dataprep/*

Contains all scripts used to clean the raw datasets and construct the analysis datasets.

These scripts include:

Importing and cleaning Foundation Skills Assessment (FSA) data.
Processing monthly satellite-derived PM₂.₅ data and calculating district-level wildfire-season exposure.
Processing National Burned Area Composite (NBAC) wildfire polygons and constructing district-level wildfire exposure measures.
Building the final analysis panel used throughout the paper.

The final cleaned datasets are saved in: *data/data_for_analysis/*

*programs/02_analysis/*

Contains scripts that reproduce all tables and figures reported in the main paper.

These scripts estimate:

Descriptive statistics
First-stage regression
Instrumental variables estimates
Main figures and maps

All outputs are automatically saved in *results/* using filenames corresponding to the tables and figures reported in the paper.

*programs/03_appendix/*

Contains scripts used to generate all appendix tables and robustness checks, including:

Ordinary Least Squares (OLS) estimates
COVID-19 exclusion robustness check
Alternative 75 km wildfire buffer specification
Excluding the 2023 wildfire season

Outputs are saved in *results/* using filenames corresponding to the appendix tables.


## Instructions to Replicators

Two replication options are provided.

*Option 1: Full Replication*

This option reproduces the complete analysis beginning with the original raw datasets.

Download the original datasets listed in the Data Availability section and place them in the appropriate folders under data/raw_data/
Run programs/00_setup.R
Run programs/01_main_full.R

This script executes all data preparation, estimation, table generation, and figure generation from the raw data.

*Expected runtime: approximately 8–10 hours*, primarily due to processing the monthly PM₂.₅ raster files.

*Option 2: Quick Replication*

This option begins from the cleaned analysis datasets contained in data/data_for_analysis/

Run programs/00_setup.R
Run programs/02_main_quick.R

This script reproduces:

the final analysis panel,
all regression results,
all tables,
all figures, and
all appendix outputs.

*Expected runtime: less than 10 minutes*

Notes: 
All intermediate datasets are saved as both .csv and .rds files to improve transparency and reproducibility.
Figure and table scripts automatically save outputs to the results/ folder.
The analysis is fully reproducible without requiring manual intervention after the appropriate replication script has been launched.

### Details on various programs

*programs/00_setup.R*
Installs all required R packages used throughout the project.
This script should be run once before executing any other programs.

*programs/01_dataprep/*

Contains all scripts used to construct the analysis datasets from the original raw data.

Cleaning and preparing Foundation Skills Assessment (FSA) data.
Processing monthly ACAG PM₂.₅ raster files to calculate district-level wildfire-season exposure.
Processing National Burned Area Composite (NBAC) wildfire polygons to construct wildfire exposure measures.
Building the final district-year analysis panel used throughout the paper.

These scripts should be run in numerical order.

The PM₂.₅ processing script is the most computationally intensive component of the replication package and requires approximately 8 hours to complete. 
All other data preparation scripts complete within a few minutes.

*programs/02_analysis/*

Contains scripts used to reproduce all tables and figures reported in the main paper.

The scripts generate:

Table 1: Summary Statistics
Table 2: First-Stage Regression Results
Table 3: Instrumental Variables Estimates
Figure 1: Spatial Distribution of Wildfire Smoke Exposure Across British Columbia School Districts

Each script automatically saves its output to the results/ folder.

Scripts should be run in numerical order.

*programs/03_appendix/*

Contains scripts used to reproduce all appendix tables and robustness checks.

The scripts generate:

Appendix Table A1: Ordinary Least Squares Estimates
Appendix Table A2: Excluding COVID-19 (2020–2021)
Appendix Table A3: Alternative 75 km Wildfire Buffer
Appendix Table A4: Excluding the 2023 Wildfire Season

Outputs are automatically saved to the results/ folder.

Scripts should be run in numerical order.

Main Replication Scripts 

Two master scripts are provided for replication:

*programs/01_main_full.R* reproduces the complete analysis beginning with the raw datasets, including PM₂.₅ extraction.
*programs/02_main_quick.R* reproduces all tables and figures beginning from the cleaned datasets contained in data/data_for_analysis.


## List of tables and programs


> INSTRUCTIONS: Your programs should clearly identify the tables and figures as they appear in the manuscript, by number. Sometimes, this may be obvious, e.g. a program called "`table1.do`" generates a file called `table1.png`. Sometimes, mnemonics are used, and a mapping is necessary. In all circumstances, provide a list of tables and figures, identifying the program (and possibly the line number) where a figure is created.
>
> NOTE: If the public repository is incomplete, because not all data can be provided, as described in the data section, then the list of tables should clearly indicate which tables, figures, and in-text numbers can be reproduced with the public material provided.

The provided code reproduces:

- [ ] All numbers provided in text in the paper
- [ ] All tables and figures in the paper
- [ ] Selected tables and figures in the paper, as explained and justified below.


| Figure/Table #    | Program                  | Line Number | Output file                      | Note                            |
|-------------------|--------------------------|-------------|----------------------------------|---------------------------------|
| Table 1           | 02_analysis/table1.do    |             | summarystats.csv                 ||
| Table 2           | 02_analysis/table2and3.do| 15          | table2.csv                       ||
| Table 3           | 02_analysis/table2and3.do| 145         | table3.csv                       ||
| Figure 1          | n.a. (no data)           |             |                                  | Source: Herodus (2011)          |
| Figure 2          | 02_analysis/fig2.do      |             | figure2.png                      ||
| Figure 3          | 02_analysis/fig3.do      |             | figure-robustness.png            | Requires confidential data      |

## References

> INSTRUCTIONS: As in any scientific manuscript, you should have proper references. For instance, in this sample README, we cited "Ruggles et al, 2019" and "DESE, 2019" in a Data Availability Statement. The reference should thus be listed here, in the style of your journal:

Steven Ruggles, Steven M. Manson, Tracy A. Kugler, David A. Haynes II, David C. Van Riper, and Maryia Bakhtsiyarava. 2018. "IPUMS Terra: Integrated Data on Population and Environment: Version 2 [dataset]." Minneapolis, MN: *Minnesota Population Center, IPUMS*. https://doi.org/10.18128/D090.V2

Department of Elementary and Secondary Education (DESE), 2019. "Student outcomes database [dataset]" *Massachusetts Department of Elementary and Secondary Education (DESE)*. Accessed January 15, 2019.

U.S. Bureau of Economic Analysis (BEA). 2016. “Table 30: "Economic Profile by County, 1969-2016.” (accessed Sept 1, 2017).

Inglehart, R., C. Haerpfer, A. Moreno, C. Welzel, K. Kizilova, J. Diez-Medrano, M. Lagos, P. Norris, E. Ponarin & B. Puranen et al. (eds.). 2014. World Values Survey: Round Six - Country-Pooled Datafile Version: http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp. Madrid: JD Systems Institute.

---

## Acknowledgements

Some content on this page was copied from [Hindawi](https://www.hindawi.com/research.data/#statement.templates). Other content was adapted  from [Fort (2016)](https://doi.org/10.1093/restud/rdw057), Supplementary data, with the author's permission.

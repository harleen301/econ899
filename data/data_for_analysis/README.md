# Data for Analysis

This folder contains the cleaned and processed data sets used in the analysis. 
These files are included in the repository and provide the starting point for the 
standard replication. This allows the paper's results to be reproduced without rerunning 
the computationally intensive processing of the original spatial and satellite data.

The programs used to construct these data sets from the original raw data are 
provided in `programs/01_dataprep/`.


## Final Analysis Panels

- `final_panel.rds` and `final_panel.csv`  
  Final district-year-grade analysis panel using wildfire activity measured within
  the baseline 50 km buffer.

- `final_panel_75km.rds` and `final_panel_75km.csv`  
  Alternative analysis panel using wildfire activity measured within a 75 km buffer 
  for the robustness analysis.


## FSA Data

- `fsa_num.rds` and `fsa_num.csv`  
  Cleaned district-level FSA Numeracy results for Grade 4 and Grade 7 students from 2017–2024.

- `fsa_province_stats.rds` and `fsa_province_stats.csv`  
  Province-level average Numeracy scores and standard deviations by year and grade.
  These statistics are used to construct the standardized numeracy outcome used in the main analysis.


## PM2.5 Exposure Data

- `pm25_monthly.rds` and `pm25_monthly.csv`  
  District-level monthly PM2.5 concentrations for 2017–2024 derived from the satellite PM2.5 data.

- `pm25_yearly.rds` and `pm25_yearly.csv`  
  District-year average PM2.5 concentrations over the May–September wildfire season.


## Wildfire Data

- `wildfire_monthly_50km.rds` and `wildfire_monthly_50km.csv`  
  Monthly wildfire activity measured within 50 km of each school district.

- `wildfire_yearly_50km.rds` and `wildfire_yearly_50km.csv`  
  District-year wildfire activity measured within the baseline 50 km buffer.

- `wildfire_monthly_75km.rds` and `wildfire_monthly_75km.csv`  
  Monthly wildfire activity measured within 75 km of each school district.

- `wildfire_yearly_75km.rds` and `wildfire_yearly_75km.csv`  
  District-year wildfire activity measured within the alternative 75 km buffer.


## Spatial Data

- `school_district_boundaries.rds`  
  Processed spatial boundaries for British Columbia school districts.

- `nbac_bc_clean.rds`  
  Processed National Burned Area Composite wildfire data restricted to British Columbia.


## Replication Note

The standard replication uses the processed data sets in this folder and does not require the original raw data.

Running `programs/01_main.R` rebuilds the final analysis panels from the relevant processed files 
and then reproduces the main and appendix results.

The original raw-data processing programs are retained in `programs/01_dataprep/` for transparency but 
are not executed by default because processing the satellite PM2.5 and spatial data is 
significantly more computationally intensive.
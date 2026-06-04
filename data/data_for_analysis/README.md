# Data for analysis

This folder contains cleaned datasets generated from the raw data in
`/data/raw_data` by the scripts in `/programs/01_dataprep`.

The contents of this folder are not tracked in Git and can be recreated by 
running the data preparation scripts.

Current datasets include:

## PM2.5 Exposure Data

File:
`pm25_monthly.csv`
`pm25_monthly.rds`

Description:
District-level monthly PM2.5 exposure measures for British Columbia school 
districts derived from satellite-based PM2.5 estimates. The dataset contains 
average PM2.5 concentrations by district, year, and month for 2017–2024.

Created by:
`programs/01_dataprep/01_extract_pm25.R`

## FSA Numeracy Data

File:
`fsa_num.csv`
`fsa_num.rds`

Description:
District-level Foundation Skills Assessment (FSA) Numeracy results for Grades 4 
and 7, All Students, from 2017–2024. Variables include average score, median 
score, standard deviation, and number of writers.

Created by:
`programs/01_dataprep/02_clean_fsa.R`

Additional cleaned datasets and the final analysis panel will be 
added to this folder as the project progresses.

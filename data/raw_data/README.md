# Raw Data

This folder is intended to contain the original raw data used to construct the processed
data sets for the project. The original raw data files are not included in the repository. 
All three primary data sources are publicly available from their respective providers. 
The standard replication does not require these files because the processed data sets are 
included in `data/data_for_analysis/`.

The programs used to process the original data are provided in `programs/01_dataprep/`.


## PM2.5 Data

**Source:** Atmospheric Composition Analysis Group (ACAG), Washington University in St. Louis

**Website:**  
https://sites.wustl.edu/acag/surface-pm2-5/

**Description:**  
Monthly satellite-derived surface PM2.5 concentration estimates for North America. 
he data are provided as NetCDF (`.nc`) files at approximately 1 km spatial resolution.
Monthly PM2.5 concentrations are spatially aggregated to British Columbia school districts 
and used to construct average wildfire-season exposure from May through September.

**Years used:** 2017–2024

**Raw data location:**  
`data/raw_data/PM2.5/`


## Foundation Skills Assessment (FSA) Data

**Source:** Education Analytics Office, Government of British Columbia

**Source website:**  
https://www2.gov.bc.ca/gov/content?id=33B2B62049BF484EBE270F95A46075B0

**Description:**  
District-level Foundation Skills Assessment results for British Columbia students.
The analysis uses Numeracy results for Grade 4 and Grade 7 students in the All Students category.

The analysis also uses province-level FSA average scores and standard deviations to 
construct year- and grade-specific standardized numeracy outcomes.

**Years used:** 2017–2024

**Licence:** Open Government Licence – British Columbia

**Raw data location:**  
`data/raw_data/FSA/`


## Wildfire Data

**Source:** Natural Resources Canada, Canadian Forest Service

**Dataset:** National Burned Area Composite (NBAC)

**Description:**  
Geospatial wildfire burned-area data for Canada. The data are restricted to 
British Columbia and used to construct district-year measures of total hectares burned
within 50 km of each school district. A 75 km measure is also constructed for the 
alternative-buffer robustness specification.

**Years used:** 2017–2024

**Raw data location:**  
`data/raw_data/Wildfire/`
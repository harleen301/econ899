# ------------------------------------------------------------
# Main data preparation program
# ------------------------------------------------------------
# This program constructs the final analysis datasets.
#
# By default, the replication uses the processed data files
# included in data/data_for_analysis/. This allows the main
# results to be reproduced quickly (otherwise it would take you ~8 hours to 
# just run the PM 2.5 data files)
#
# The code required to reconstruct the processed datasets from
# the original raw data is provided below but is not run by
# default because the spatial processing of the satellite
# PM2.5 data is computationally intensive.
# ------------------------------------------------------------


source("programs/config.R")


# ------------------------------------------------------------
# OPTIONAL: Reconstruct processed data from raw sources
# ------------------------------------------------------------
# Uncomment the following programs to reconstruct the processed
# datasets from the original raw data.
#
# Note: The original raw data must first be obtained and placed
# in the appropriate folders under data/raw_data/. Processing
# the satellite PM2.5 data requires substantially more runtime.
#
# source(file.path(dataprep_dir, "11_extract_pm2.5.R"))
# source(file.path(dataprep_dir, "12_clean_fsa.R"))
# source(file.path(dataprep_dir, "13_prep_wildfires.R"))
# source(file.path(dataprep_dir, "15_wildfire_75km.R"))

# ------------------------------------------------------------
# Standard replication: Realistic Replication 
# ------------------------------------------------------------


# ------------------------------------------------------------
# Build baseline analysis panel
# ------------------------------------------------------------

source(
  file.path(
    dataprep_dir,
    "14_build_panel.R"
  )
)


# ------------------------------------------------------------
# Build 75 km robustness panel
# ------------------------------------------------------------

source(
  file.path(
    dataprep_dir,
    "16_build_panel_75km.R"
  )
)

cat("Data preparation complete.\n")
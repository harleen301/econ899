# ------------------------------------------------------------
# config.R
# ------------------------------------------------------------
# Purpose:
# Configuration file called at the beginning of every data
# preparation and analysis script.
#
# This is the only file that a user may need to edit.
# ------------------------------------------------------------


# ------------------------------------------------------------
# 1. Project location
# ------------------------------------------------------------

# EDIT THIS PATH if the repository is stored elsewhere.
repo_root <- "C:/Users/HKAURSAN/WINDOWS/GitHub/econ899"

# Set project working directory
setwd(repo_root)

# ------------------------------------------------------------
# 2. Project folders
# ------------------------------------------------------------

programs_dir <- file.path(repo_root, "programs")

dataprep_dir <- file.path(
  programs_dir,
  "01_dataprep")

analysis_dir <- file.path(
  programs_dir,
  "02_analysis")

appendix_dir <- file.path(
  programs_dir,
  "03_appendix")

# Data
data_dir <- file.path(
  repo_root,
  "data")

raw_data_dir <- file.path(
  data_dir,
  "raw_data")

pm25_raw_dir <- file.path(
  raw_data_dir,
  "PM2.5")

fsa_raw_dir <- file.path(
  raw_data_dir,
  "FSA")

wildfire_raw_dir <- file.path(
  raw_data_dir,
  "Wildfire")

data_analysis_dir <- file.path(
  data_dir,
  "data_for_analysis")


# Results
results_dir <- file.path(
  repo_root,
  "results")



# ------------------------------------------------------------
# 3. Load required packages
# ------------------------------------------------------------

required_packages <- c(
  "tidyverse",
  "sf",
  "terra",
  "exactextractr",
  "bcdata",
  "readxl",
  "lubridate",
  "patchwork",
  "scales",
  "fixest"
)

invisible(
  lapply(
    required_packages,
    library,
    character.only = TRUE
  )
)


# ------------------------------------------------------------
# 4. General options
# ------------------------------------------------------------

options(stringsAsFactors = FALSE)
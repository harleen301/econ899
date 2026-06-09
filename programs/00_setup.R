
# 00_setup.R
# Purpose: Install/load required packages and create project folders.
# This file is designed to be run once, but it is safe to rerun.


# Packages used in this project
required_packages <- c(
  "tidyverse",
  "sf",
  "terra",
  "exactextractr",
  "bcdata",
  "readxl",
  "lubridate",
  "here")

# Install missing packages
installed_packages <- rownames(installed.packages())

for (pkg in required_packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
}

# Load packages
lapply(required_packages, library, character.only = TRUE)

# Create required folders if they do not already exist
folders <- c(
  "data/raw_data/PM2.5",
  "data/raw_data/FSA",
  "data/raw_data/Wildfire")

for (folder in folders) {
  if (!dir.exists(folder)) {
    dir.create(folder, recursive = TRUE)
  }
}



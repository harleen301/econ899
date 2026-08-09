# ------------------------------------------------------------
# Main analysis program
# ------------------------------------------------------------
# Purpose:
# Run all programs required to reproduce the main figure
# and tables reported in the paper.
# ------------------------------------------------------------

source("programs/config.R")


# ------------------------------------------------------------
# Figure 1
# ------------------------------------------------------------

source(
  file.path(
    analysis_dir,
    "figure01.R"
  )
)


# ------------------------------------------------------------
# Table 1: Summary statistics
# ------------------------------------------------------------

source(
  file.path(
    analysis_dir,
    "table01.R"
  )
)


# ------------------------------------------------------------
# Table 2: First-stage results
# ------------------------------------------------------------

source(
  file.path(
    analysis_dir,
    "table02.R"
  )
)


# ------------------------------------------------------------
# Table 3: Main IV and OLS results
# ------------------------------------------------------------

source(
  file.path(
    analysis_dir,
    "table03.R"
  )
)


cat("Main analysis complete.\n")
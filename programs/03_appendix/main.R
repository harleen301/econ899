# ------------------------------------------------------------
# Main appendix program
# ------------------------------------------------------------
# Purpose:
# Run all programs required to reproduce the appendix tables.
# ------------------------------------------------------------

source("programs/config.R")


# ------------------------------------------------------------
# Appendix Table A1
# ------------------------------------------------------------

source(
  file.path(
    appendix_dir,
    "tableA1.R"
  )
)


# ------------------------------------------------------------
# Appendix Table A2
# ------------------------------------------------------------

source(
  file.path(
    appendix_dir,
    "tableA2.R"
  )
)


cat("Appendix analysis complete.\n")
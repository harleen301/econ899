library(dplyr)
library(fixest)

# ------------------------------------------------------------
# Load final panel
# ------------------------------------------------------------

panel <- readRDS(
  "data/data_for_analysis/final_panel.rds"
)

# Check data
stopifnot(nrow(panel) == 944)

# ------------------------------------------------------------
# Create grade-specific samples
# ------------------------------------------------------------

panel_g4 <- panel %>%
  filter(GRADE == "04")

panel_g7 <- panel %>%
  filter(GRADE == "07")

# ------------------------------------------------------------
# OLS model: Grade 4
# ------------------------------------------------------------

ols_g4 <- feols(
  AVG_SCORE ~ pm25 |
    SCHOOL_DISTRICT_NUMBER + year,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g4
)

# ------------------------------------------------------------
# OLS model: Grade 7
# ------------------------------------------------------------

ols_g7 <- feols(
  AVG_SCORE ~ pm25 |
    SCHOOL_DISTRICT_NUMBER + year,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g7
)

# ------------------------------------------------------------
# Save Appendix Table A1
# ------------------------------------------------------------

capture.output(
  etable(
    ols_g4,
    ols_g7,
    digits = 3,
    dict = c(
      pm25 = "PM2.5"
    )
  ),
  file = "results/tableA1_ols_results.txt"
)
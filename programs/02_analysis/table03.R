source("programs/config.R")

# Load final panel
panel <- readRDS("data/data_for_analysis/final_panel.rds")

# Check data
stopifnot(nrow(panel) == 944)

# Rescale burned area
panel <- panel %>%
  mutate(burned_ha_100k = burned_ha / 100000)

# Grade-specific samples
panel_g4 <- panel %>%
  filter(GRADE == "04")

panel_g7 <- panel %>%
  filter(GRADE == "07")

# OLS model: Grade 4

ols_g4 <- feols(
  AVG_SCORE_Z ~ pm25 |
    SCHOOL_DISTRICT_NUMBER + year,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g4
)

# OLS model: Grade 7

ols_g7 <- feols(
  AVG_SCORE_Z ~ pm25 |
    SCHOOL_DISTRICT_NUMBER + year,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g7
)

# IV model: Grade 4
iv_g4 <- feols(
  AVG_SCORE_Z ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g4)

# IV model: Grade 7
iv_g7 <- feols(
  AVG_SCORE_Z ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g7)


# Save main results table
capture.output(
  etable(
    iv_g4,
    iv_g7,
    ols_g4,
    ols_g7,
    digits = 5,
    headers = c(
      "Grade 4 IV",
      "Grade 7 IV",
      "Grade 4 OLS",
      "Grade 7 OLS"
    ),
    dict = c(
      pm25 = "PM2.5"
    )
  ),
  file = "results/table03_main_results.txt"
)


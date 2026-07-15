library(dplyr)
library(fixest)

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

# IV model: Grade 4
iv_g4 <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g4)

# IV model: Grade 7
iv_g7 <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_g7)


# Save main results table
capture.output(
  etable(
    iv_g4,
    iv_g7,
    digits = 3,
    dict = c(
      pm25 = "PM2.5")),file = "results/table03_main_results.txt")




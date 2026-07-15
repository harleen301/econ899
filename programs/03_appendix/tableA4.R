# Load final panel
panel <- readRDS("data/data_for_analysis/final_panel.rds")

# Check data
stopifnot(nrow(panel) == 944)

# Exclude 2023
panel_no2023 <- panel %>%
  filter(year != 2023)


panel_no2023 <- panel %>%
  filter(year != 2023) %>%
  mutate(
    burned_ha_100k = burned_ha / 100000)

# Grade-specific samples
panel_no2023_g4 <- panel_no2023 %>%
  filter(GRADE == "04")

panel_no2023_g7 <- panel_no2023 %>%
  filter(GRADE == "07")

# IV model: Grade 4, excluding 2023
iv_no2023_g4 <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_no2023_g4
)

# IV model: Grade 7, excluding 2023
iv_no2023_g7 <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_no2023_g7
)

# Save Appendix Table A4: IV results excluding 2023
capture.output(
  etable(
    iv_no2023_g4,
    iv_no2023_g7,
    digits = 3,
    dict = c(pm25 = "PM2.5")
  ),
  file = "results/tableA4_2023_robustness.txt"
)


# First-stage diagnostics
summary(iv_no2023_g4, stage = 1)
summary(iv_no2023_g7, stage = 1)
source("programs/config.R")

# Load final panel
panel <- readRDS("data/data_for_analysis/final_panel.rds")

# Check data
stopifnot(nrow(panel) == 944)

panel_no_covid <- panel %>%
  filter(!year %in% c(2020, 2021)) %>%
  mutate(
    burned_ha_100k = burned_ha / 100000)

panel_no_covid_g4 <- panel_no_covid %>%
  filter(GRADE == "04")

panel_no_covid_g7 <- panel_no_covid %>%
  filter(GRADE == "07")

iv_g4_no_covid <- feols(
  AVG_SCORE_Z ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~ SCHOOL_DISTRICT_NUMBER,
  data = panel_no_covid_g4)

iv_g7_no_covid <- feols(
  AVG_SCORE_Z ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~ SCHOOL_DISTRICT_NUMBER,
  data = panel_no_covid_g7)

# Save Appendix Table A2: IV results excluding 2020 and 2021
capture.output(
  etable(
    iv_g4_no_covid,
    iv_g7_no_covid,
    digits = 5,
    dict = c(
      pm25 = "PM2.5"
    )
  ),
  file = "results/tableA2_covid_robustness.txt"
)
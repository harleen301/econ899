library(dplyr)
library(fixest)

# ------------------------------------------------------------
# 1. Load 75 km robustness panel
# ------------------------------------------------------------

panel_75km <- readRDS(
  "data/data_for_analysis/final_panel_75km.rds"
)

# Check data
stopifnot(nrow(panel_75km) == 944)

# ------------------------------------------------------------
# 2. Rescale burned area
# ------------------------------------------------------------

panel_75km <- panel_75km %>%
  mutate(
    burned_ha_75km_100k = burned_ha_75km / 100000)

# ------------------------------------------------------------
# 3. Create grade-specific samples
# ------------------------------------------------------------

panel_75km_g4 <- panel_75km %>%
  filter(GRADE == "04")

panel_75km_g7 <- panel_75km %>%
  filter(GRADE == "07")

# ------------------------------------------------------------
# 4. IV model: Grade 4
# ------------------------------------------------------------

iv_g4_75km <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_75km_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_75km_g4
)

# ------------------------------------------------------------
# 5. IV model: Grade 7
# ------------------------------------------------------------

iv_g7_75km <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_75km_100k,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_75km_g7
)

# ------------------------------------------------------------
# 6. Save Appendix Table A3
# ------------------------------------------------------------

capture.output(
  etable(
    iv_g4_75km,
    iv_g7_75km,
    digits = 3,
    dict = c(
      pm25 = "PM2.5"
    )
  ),
  file = "results/tableA3_buffer75km.txt"
)
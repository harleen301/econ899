library(dplyr)
library(fixest)

# Load final panel
panel <- readRDS("data/data_for_analysis/final_panel.rds")

# Check data
stopifnot(nrow(panel) == 944)

# Create district-year data
panel_dy <- panel %>%
  distinct(
    SCHOOL_DISTRICT_NUMBER,
    year,
    pm25,
    burned_ha
  ) %>%
  mutate(
    burned_ha_100k = burned_ha / 100000)

stopifnot(nrow(panel_dy) == 472)

# First-stage regression
fs1 <- feols(
  pm25 ~ burned_ha_100k |
    SCHOOL_DISTRICT_NUMBER + year,
  cluster = ~SCHOOL_DISTRICT_NUMBER,
  data = panel_dy)

panel <- panel %>%
  mutate(
    burned_ha_100k = burned_ha / 100000
  )

panel_g4 <- panel %>%
  filter(GRADE == "04")

iv_temp <- feols(
  AVG_SCORE ~ 1 |
    SCHOOL_DISTRICT_NUMBER + year |
    pm25 ~ burned_ha_100k,
  cluster = ~ SCHOOL_DISTRICT_NUMBER,
  data = panel_g4
)

# Save table as text file in results
capture.output(
  {
    etable(
      fs1,
      digits = 3,
      dict = c(
        burned_ha_100k = "Burned area within 50 km (100,000 ha)"
      )
    )
    
    cat("\n\nFirst-stage diagnostics\n\n")
    
    summary(iv_temp, stage = 1)
  },
  file = "results/table02_first_stage.txt"
)

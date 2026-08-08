source("programs/config.R")

# -----------------------------------------------------------
# 1. Load datasets
# ------------------------------------------------------------

pm25_yearly <- readRDS(
  "data/data_for_analysis/pm25_yearly.rds"
)

wildfire_yearly_75km <- readRDS(
  "data/data_for_analysis/wildfire_yearly_75km.rds"
)

fsa_num <- readRDS(
  "data/data_for_analysis/fsa_num.rds"
)

final_panel <- readRDS(
  "data/data_for_analysis/final_panel.rds"
)

# ------------------------------------------------------------
# 2. Standardize district identifiers
# ------------------------------------------------------------

fsa_num <- fsa_num %>%
  rename(
    SCHOOL_DISTRICT_NUMBER = DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME = DISTRICT_NAME
  )

# ------------------------------------------------------------
# 3. Merge datasets
# ------------------------------------------------------------

panel_75km <- fsa_num %>%
  left_join(
    pm25_yearly %>%
      select(
        SCHOOL_DISTRICT_NUMBER,
        year,
        pm25
      ),
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "year"
    )
  ) %>%
  left_join(
    wildfire_yearly_75km %>%
      select(
        SCHOOL_DISTRICT_NUMBER,
        year,
        burned_ha_75km,
        fire_count_75km
      ),
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "year"
    )
  )

# ------------------------------------------------------------
# 4. Keep analysis variables
# ------------------------------------------------------------

panel_75km <- panel_75km %>%
  select(
    SCHOOL_DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME,
    year,
    GRADE,
    NUMBER_WRITERS,
    AVG_SCORE,
    MEDIAN_SCORE,
    STDEV_SCORE,
    pm25,
    burned_ha_75km,
    fire_count_75km
  )

panel_75km <- panel_75km %>%
  left_join(
    final_panel %>%
      select(
        SCHOOL_DISTRICT_NUMBER,
        year,
        GRADE,
        AVG_SCORE_Z
      ),
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "year",
      "GRADE"
    )
  )

# ------------------------------------------------------------
# 5. Checks
# ------------------------------------------------------------

cat("\nPanel dimensions:\n")
print(dim(panel_75km))

cat("\nMissing PM2.5:\n")
print(sum(is.na(panel_75km$pm25)))

cat("\nMissing burned area:\n")
print(sum(is.na(panel_75km$burned_ha_75km)))

cat("\nMissing fire count:\n")
print(sum(is.na(panel_75km$fire_count_75km)))

cat("\nGrades:\n")
print(table(panel_75km$GRADE))

cat("\nYears:\n")
print(table(panel_75km$year))

stopifnot(nrow(panel_75km) == 944)
stopifnot(sum(is.na(panel_75km$pm25)) == 0)
stopifnot(sum(is.na(panel_75km$burned_ha_75km)) == 0)

# ------------------------------------------------------------
# 6. Save 75 km robustness panel
# ------------------------------------------------------------

write.csv(
  panel_75km,
  "data/data_for_analysis/final_panel_75km.csv",
  row.names = FALSE
)

saveRDS(
  panel_75km,
  "data/data_for_analysis/final_panel_75km.rds"
)
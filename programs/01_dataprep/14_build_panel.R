library(dplyr)

# ------------------------------------------------------------
# 1. Load datasets
# ------------------------------------------------------------

pm25_yearly <- readRDS(
  "data/data_for_analysis/pm25_yearly.rds"
)

wildfire_yearly <- readRDS(
  "data/data_for_analysis/wildfire_yearly_50km.rds"
)

fsa_num <- readRDS(
  "data/data_for_analysis/fsa_num.rds"
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

panel <- fsa_num %>%
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
    wildfire_yearly %>%
      select(
        SCHOOL_DISTRICT_NUMBER,
        year,
        burned_ha,
        fire_count
      ),
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "year"
    )
  )

panel <- panel %>%
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
    burned_ha,
    fire_count
  )


write.csv(
  panel,
  "data/data_for_analysis/final_panel.csv",
  row.names = FALSE
)

saveRDS(
  panel,
  "data/data_for_analysis/final_panel.rds"
)


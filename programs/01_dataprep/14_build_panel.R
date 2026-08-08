source("programs/config.R")

# ------------------------------------------------------------
# 1. Load main datasets
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
# 2. Load and clean province-level FSA statistics
# ------------------------------------------------------------

fsa_province_level <- read_excel(
  "data/raw_data/FSA/fsa_province_level.xlsx"
)

province_fsa_stats <- fsa_province_level %>%
  transmute(
    # Convert school year such as "2017/2018" to panel year 2017
    year = as.integer(substr(as.character(SCHOOL_YEAR), 1, 4)),
    
    # Ensure grades are stored consistently as "04" and "07"
    GRADE = sprintf(
      "%02d",
      as.integer(as.character(GRADE))
    ),
    PROVINCE_SD = as.numeric(STDEV_SCORE),
    PROVINCE_AVG = as.numeric(AVG_SCORE)
  ) %>%
  filter(
    year %in% 2017:2024,
    GRADE %in% c("04", "07")
  ) %>%
  arrange(
    year,
    GRADE
  )

# ------------------------------------------------------------
# 3. Check province-level data
# ------------------------------------------------------------

# Eight years × two grades = 16 observations
stopifnot(nrow(province_fsa_stats) == 16)

# Each year-grade combination must be unique
stopifnot(
  nrow(
    province_fsa_stats %>%
      distinct(year, GRADE)
  ) == 16
)


# Save the cleaned province-level statistics
write.csv(
  province_fsa_stats,
  "data/data_for_analysis/fsa_province_stats.csv",
  row.names = FALSE
)

saveRDS(
  province_fsa_stats,
  "data/data_for_analysis/fsa_province_stats.rds"
)

# ------------------------------------------------------------
# 4. Standardize district identifiers and grade format
# ------------------------------------------------------------

fsa_num <- fsa_num %>%
  rename(
    SCHOOL_DISTRICT_NUMBER = DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME = DISTRICT_NAME
  ) %>%
  mutate(
    year = as.integer(year),
    GRADE = sprintf(
      "%02d",
      as.integer(as.character(GRADE))
    )
  )

# ------------------------------------------------------------
# 5. Merge datasets
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
  ) %>%
  left_join(
    province_fsa_stats,
    by = c(
      "year",
      "GRADE"
    )
  )

# ------------------------------------------------------------
# 6. Create standardized numeracy outcome
# ------------------------------------------------------------

panel <- panel %>%
  mutate(
    # Main specification (year-specific z-score)
    AVG_SCORE_Z = (AVG_SCORE - PROVINCE_AVG) / PROVINCE_SD)

# ------------------------------------------------------------
# 7. Select final analysis variables
# ------------------------------------------------------------

panel <- panel %>%
  select(
    SCHOOL_DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME,
    year,
    GRADE,
    NUMBER_WRITERS,
    AVG_SCORE,
    AVG_SCORE_Z,
    MEDIAN_SCORE,
    STDEV_SCORE,
    PROVINCE_AVG,
    PROVINCE_SD,
    pm25,
    burned_ha,
    fire_count
  ) %>%
  arrange(
    SCHOOL_DISTRICT_NUMBER,
    year,
    GRADE
  )

# ------------------------------------------------------------
# 8. Save final panel
# ------------------------------------------------------------

write.csv(
  panel,
  "data/data_for_analysis/final_panel.csv",
  row.names = FALSE)

saveRDS(
  panel,
  "data/data_for_analysis/final_panel.rds")



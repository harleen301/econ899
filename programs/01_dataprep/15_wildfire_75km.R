library(sf)
library(dplyr)
library(tidyr)
library(purrr)
library(bcdata)

# ------------------------------------------------------------
# 1. Set years and wildfire-season months
# ------------------------------------------------------------

years <- 2017:2024
months_keep <- 5:9

# ------------------------------------------------------------
# 2. Load cleaned wildfire polygons
# ------------------------------------------------------------

nbac_bc <- readRDS(
  "data/data_for_analysis/nbac_bc_clean.rds"
)

# ------------------------------------------------------------
# 3. Load school districts
# ------------------------------------------------------------

districts <- bcdc_query_geodata(
  "78ec5279-4534-49a1-97e8-9d315936f08b"
) %>%
  collect()

# Transform districts to the NBAC coordinate system
districts_nbac <- st_transform(
  districts,
  st_crs(nbac_bc)
)

# ------------------------------------------------------------
# 4. Create 75 km district buffers
# ------------------------------------------------------------

district_buffers_75km <- st_buffer(
  districts_nbac,
  dist = 75000
)

# ------------------------------------------------------------
# 5. Find wildfire polygons intersecting each buffer
# ------------------------------------------------------------

fire_matches_75km <- st_intersects(
  district_buffers_75km,
  nbac_bc
)

# ------------------------------------------------------------
# 6. Aggregate wildfire exposure by district-year-month
# ------------------------------------------------------------

wildfire_results_75km <- list()

for (i in seq_along(fire_matches_75km)) {
  
  district_fires <- nbac_bc[
    fire_matches_75km[[i]],
  ]
  
  if (nrow(district_fires) == 0) {
    next
  }
  
  temp <- district_fires %>%
    st_drop_geometry() %>%
    group_by(year, month) %>%
    summarise(
      burned_ha_75km = sum(ADJ_HA, na.rm = TRUE),
      fire_count_75km = n(),
      .groups = "drop"
    ) %>%
    mutate(
      SCHOOL_DISTRICT_NUMBER =
        districts_nbac$SCHOOL_DISTRICT_NUMBER[i],
      SCHOOL_DISTRICT_NAME =
        districts_nbac$SCHOOL_DISTRICT_NAME[i]
    )
  
  wildfire_results_75km[[i]] <- temp
}

wildfire_monthly_75km <- bind_rows(
  wildfire_results_75km
)

# ------------------------------------------------------------
# 7. Create complete district-month grid
# ------------------------------------------------------------

district_month_grid <- expand_grid(
  SCHOOL_DISTRICT_NUMBER =
    districts_nbac$SCHOOL_DISTRICT_NUMBER,
  year = years,
  month = months_keep
) %>%
  left_join(
    districts_nbac %>%
      st_drop_geometry() %>%
      dplyr::select(
        SCHOOL_DISTRICT_NUMBER,
        SCHOOL_DISTRICT_NAME
      ),
    by = "SCHOOL_DISTRICT_NUMBER"
  )

# ------------------------------------------------------------
# 8. Join exposure data and fill zero-fire months
# ------------------------------------------------------------

wildfire_monthly_75km <- district_month_grid %>%
  left_join(
    wildfire_monthly_75km,
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "SCHOOL_DISTRICT_NAME",
      "year",
      "month"
    )
  ) %>%
  mutate(
    burned_ha_75km =
      replace_na(burned_ha_75km, 0),
    fire_count_75km =
      replace_na(fire_count_75km, 0),
    burned_ha_75km =
      round(burned_ha_75km)
  ) %>%
  arrange(
    SCHOOL_DISTRICT_NUMBER,
    year,
    month
  )

# ------------------------------------------------------------
# 9. Checks
# ------------------------------------------------------------

cat("\nDataset dimensions:\n")
print(dim(wildfire_monthly_75km))

cat("\nYears included:\n")
print(table(wildfire_monthly_75km$year))

cat("\nMonths included:\n")
print(table(wildfire_monthly_75km$month))

cat("\nBurned hectares summary:\n")
print(summary(
  wildfire_monthly_75km$burned_ha_75km
))

cat("\nFire count summary:\n")
print(summary(
  wildfire_monthly_75km$fire_count_75km
))

# Expected dimensions:
# 59 districts × 8 years × 5 months = 2,360 rows
stopifnot(nrow(wildfire_monthly_75km) == 2360)

# ------------------------------------------------------------
# 10. Save monthly 75 km exposure data
# ------------------------------------------------------------

write.csv(
  wildfire_monthly_75km,
  "data/data_for_analysis/wildfire_monthly_75km.csv",
  row.names = FALSE
)

saveRDS(
  wildfire_monthly_75km,
  "data/data_for_analysis/wildfire_monthly_75km.rds"
)

# ------------------------------------------------------------
# 11. Aggregate to district-year level
# ------------------------------------------------------------

wildfire_yearly_75km <- wildfire_monthly_75km %>%
  group_by(
    SCHOOL_DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME,
    year
  ) %>%
  summarise(
    burned_ha_75km =
      sum(burned_ha_75km, na.rm = TRUE),
    fire_count_75km =
      sum(fire_count_75km, na.rm = TRUE),
    .groups = "drop"
  )

# Expected dimensions:
# 59 districts × 8 years = 472 rows
stopifnot(nrow(wildfire_yearly_75km) == 472)

# ------------------------------------------------------------
# 12. Save yearly 75 km exposure data
# ------------------------------------------------------------

write.csv(
  wildfire_yearly_75km,
  "data/data_for_analysis/wildfire_yearly_75km.csv",
  row.names = FALSE
)

saveRDS(
  wildfire_yearly_75km,
  "data/data_for_analysis/wildfire_yearly_75km.rds"
)
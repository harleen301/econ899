library(sf)
library(dplyr)
library(purrr)
library(tidyr)
library(bcdata)
library(lubridate)

# ------------------------------------------------------------
# 1. Load school districts
# ------------------------------------------------------------

districts <- bcdc_query_geodata(
  "78ec5279-4534-49a1-97e8-9d315936f08b"
) %>%
  collect()

# ------------------------------------------------------------
# 2. Set wildfire folders, years, and months
# ------------------------------------------------------------

wildfire_folder <- "data/raw_data/Wildfire"

years <- 2017:2024

# Main wildfire season
months_keep <- 5:9

# ------------------------------------------------------------
# 3. Function to read one NBAC year
# ------------------------------------------------------------

read_nbac_year <- function(year) {
  
  year_folder <- list.files(
    wildfire_folder,
    pattern = paste0("NBAC_", year),
    full.names = TRUE
  )
  
  shp_file <- list.files(
    year_folder,
    pattern = "\\.shp$",
    full.names = TRUE
  )
  
  st_read(shp_file[1], quiet = TRUE)
}

# ------------------------------------------------------------
# 4. Read all NBAC wildfire files
# ------------------------------------------------------------

nbac_all <- map_dfr(years, read_nbac_year)

# ------------------------------------------------------------
# 5. Clean wildfire data
# ------------------------------------------------------------

nbac_bc <- nbac_all %>%
  filter(
    ADMIN_NAME == "BC",
    !is.na(AG_SDATE)
  ) %>%
  mutate(
    fire_date = as.Date(AG_SDATE),
    year = lubridate::year(fire_date),
    month = lubridate::month(fire_date)
  ) %>%
  filter(
    year %in% years,
    month %in% months_keep
  )

# ------------------------------------------------------------
# 6. Transform districts to NBAC CRS
# ------------------------------------------------------------

districts_nbac <- st_transform(
  districts,
  st_crs(nbac_bc)
)

# ------------------------------------------------------------
# 7. Create 50 km district buffers
# ------------------------------------------------------------

district_buffers <- st_buffer(
  districts_nbac,
  dist = 50000
)

# ------------------------------------------------------------
# 8. Find wildfire polygons intersecting each district buffer
# ------------------------------------------------------------

fire_matches <- st_intersects(
  district_buffers,
  nbac_bc
)

# ------------------------------------------------------------
# 9. Aggregate wildfire exposure by district-year-month
# ------------------------------------------------------------

wildfire_results <- list()

for (i in seq_along(fire_matches)) {
  
  district_fires <- nbac_bc[fire_matches[[i]], ]
  
  if (nrow(district_fires) == 0) {
    next
  }
  
  temp <- district_fires %>%
    st_drop_geometry() %>%
    group_by(year, month) %>%
    summarise(
      burned_ha_50km = sum(ADJ_HA, na.rm = TRUE),
      fire_count_50km = n(),
      .groups = "drop"
    ) %>%
    mutate(
      SCHOOL_DISTRICT_NUMBER = districts_nbac$SCHOOL_DISTRICT_NUMBER[i],
      SCHOOL_DISTRICT_NAME = districts_nbac$SCHOOL_DISTRICT_NAME[i]
    )
  
  wildfire_results[[i]] <- temp
}

wildfire_monthly <- bind_rows(wildfire_results)

# ------------------------------------------------------------
# 10. Create complete district-month grid
# ------------------------------------------------------------

district_month_grid <- expand_grid(
  SCHOOL_DISTRICT_NUMBER = districts_nbac$SCHOOL_DISTRICT_NUMBER,
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
# 11. Join exposure data and fill zero-fire months
# ------------------------------------------------------------

wildfire_monthly <- district_month_grid %>%
  left_join(
    wildfire_monthly,
    by = c(
      "SCHOOL_DISTRICT_NUMBER",
      "SCHOOL_DISTRICT_NAME",
      "year",
      "month"
    )
  ) %>%
  mutate(
    burned_ha_50km = replace_na(burned_ha_50km, 0),
    fire_count_50km = replace_na(fire_count_50km, 0),
    burned_ha_50km = round(burned_ha_50km)
  ) %>%
  arrange(
    SCHOOL_DISTRICT_NUMBER,
    year,
    month
  )

# ------------------------------------------------------------
# 12. Checks
# ------------------------------------------------------------

cat("\nDataset dimensions:\n")
print(dim(wildfire_monthly))

cat("\nYears included:\n")
print(table(wildfire_monthly$year))

cat("\nMonths included:\n")
print(table(wildfire_monthly$month))

cat("\nBurned hectares summary:\n")
print(summary(wildfire_monthly$burned_ha_50km))

cat("\nFire count summary:\n")
print(summary(wildfire_monthly$fire_count_50km))

# ------------------------------------------------------------
# 13. Save
# ------------------------------------------------------------

write.csv(
  wildfire_monthly,
  "data/data_for_analysis/wildfire_monthly_50km.csv",
  row.names = FALSE
)

saveRDS(
  wildfire_monthly,
  "data/data_for_analysis/wildfire_monthly_50km.rds"
)



library(terra)
library(exactextractr)

library(bcdata)
library(sf)
library(dplyr)
library(stringr)

# Load districts
districts <- bcdc_query_geodata("78ec5279-4534-49a1-97e8-9d315936f08b") %>%
  collect()

# Path to PM2.5 data
pm25_folder <- "data/raw_data/PM2.5"

# Get all nc files in folder
files <- list.files(
  pm25_folder,
  pattern = "\\.nc$",
  full.names = TRUE
)

# Check files found
cat("Number of files found:", length(files), "\n")

# Use first file to get CRS
pm25_test <- rast(files[1])

# Reproject districts once
districts_proj <- st_transform(districts, crs(pm25_test))
districts_vect <- vect(districts_proj)

# Store results
results <- list()

for (i in seq_along(files)) {
  
  file <- files[i]
  
  cat("\nProcessing:", basename(file), "\n")
  
  # Extract year and month from filename
  year_month <- str_extract(
    basename(file),
    "\\d{6}"
  )
  
  year <- as.integer(substr(year_month, 1, 4))
  month <- as.integer(substr(year_month, 5, 6))
  
  # Load raster
  pm25 <- rast(file)
  
  # Crop to BC
  pm25_bc <- crop(pm25, districts_vect)
  
  # Mask to district boundaries
  pm25_bc <- mask(pm25_bc, districts_vect)
  
  # Remove invalid values
  pm25_bc[pm25_bc < 0] <- NA
  
  cat("Raster prepared\n")
  
  # Extract district means
  pm25_mean <- exact_extract(
    pm25_bc,
    districts_proj,
    "mean"
  )
  
  cat("Extraction complete\n")
  
  temp <- districts_proj %>%
    st_drop_geometry() %>%
    dplyr::select(
      SCHOOL_DISTRICT_NAME,
      SCHOOL_DISTRICT_NUMBER
    ) %>%
    mutate(
      year = year,
      month = month,
      pm25_mean = pm25_mean
    )
  
  results[[i]] <- temp
  
  cat("Saved results for file", i, "\n")
}

# Combine all months
pm25_monthly <- bind_rows(results)

# Keep only needed columns
pm25_monthly <- pm25_monthly %>%
  dplyr::select(
    SCHOOL_DISTRICT_NAME,
    SCHOOL_DISTRICT_NUMBER,
    year,
    month,
    pm25_mean
  )


#Quick Checks 

cat("\nDataset dimensions:\n")
print(dim(pm25_monthly))

cat("\nYears included:\n")
print(table(pm25_monthly$year))

cat("\nMonths included:\n")
print(table(pm25_monthly$month))

cat("\nPM2.5 summary:\n")
print(summary(pm25_monthly$pm25_mean))

# Save cleaned PM2.5 data

write.csv(
  pm25_monthly,
  "data/data_for_analysis/pm25_monthly.csv",
  row.names = FALSE
)

saveRDS(
  pm25_monthly,
  "data/data_for_analysis/pm25_monthly.rds"
)

### Aggregate to Yearly 

# Load monthly PM2.5 data
pm25_monthly <- readRDS(
  "data/data_for_analysis/pm25_monthly.rds"
)


# Create May-September district-year PM2.5 exposure
pm25_yearly <- pm25_monthly %>%
  filter(month %in% 5:9) %>%
  group_by(
    SCHOOL_DISTRICT_NUMBER,
    SCHOOL_DISTRICT_NAME,
    year
  ) %>%
  summarise(
    pm25 = mean(pm25_mean, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(SCHOOL_DISTRICT_NUMBER, year)

# Checks
dim(pm25_yearly)
table(pm25_yearly$year)
summary(pm25_yearly$pm25)

# Save yearly PM2.5 data
write.csv(
  pm25_yearly,
  "data/data_for_analysis/pm25_yearly.csv",
  row.names = FALSE
)

saveRDS(
  pm25_yearly,
  "data/data_for_analysis/pm25_yearly.rds"
)
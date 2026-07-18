library(dplyr)

# Load final panel
panel <- readRDS("data/data_for_analysis/final_panel.rds")

# Check data
stopifnot(nrow(panel) == 944)

# District-year data for exposure variables
panel_dy <- panel %>%
  distinct(
    SCHOOL_DISTRICT_NUMBER,
    year,
    pm25,
    burned_ha)

# Create Table 1
table1 <- bind_rows(
  
  # Raw Grade 4 score
  panel %>%
    filter(GRADE == "04") %>%
    summarise(
      Variable = "Numeracy score (Grade 4)",
      Min = min(AVG_SCORE, na.rm = TRUE),
      Q1 = quantile(AVG_SCORE, 0.25, na.rm = TRUE),
      Median = median(AVG_SCORE, na.rm = TRUE),
      Mean = mean(AVG_SCORE, na.rm = TRUE),
      SD = sd(AVG_SCORE, na.rm = TRUE),
      Q3 = quantile(AVG_SCORE, 0.75, na.rm = TRUE),
      Max = max(AVG_SCORE, na.rm = TRUE)
    ),
  
  # Standardized Grade 4 score
  panel %>%
    filter(GRADE == "04") %>%
    summarise(
      Variable = "Numeracy z-score (Grade 4)",
      Min = min(AVG_SCORE_Z, na.rm = TRUE),
      Q1 = quantile(AVG_SCORE_Z, 0.25, na.rm = TRUE),
      Median = median(AVG_SCORE_Z, na.rm = TRUE),
      Mean = mean(AVG_SCORE_Z, na.rm = TRUE),
      SD = sd(AVG_SCORE_Z, na.rm = TRUE),
      Q3 = quantile(AVG_SCORE_Z, 0.75, na.rm = TRUE),
      Max = max(AVG_SCORE_Z, na.rm = TRUE)
    ),
  
  # Raw Grade 7 score
  panel %>%
    filter(GRADE == "07") %>%
    summarise(
      Variable = "Numeracy score (Grade 7)",
      Min = min(AVG_SCORE, na.rm = TRUE),
      Q1 = quantile(AVG_SCORE, 0.25, na.rm = TRUE),
      Median = median(AVG_SCORE, na.rm = TRUE),
      Mean = mean(AVG_SCORE, na.rm = TRUE),
      SD = sd(AVG_SCORE, na.rm = TRUE),
      Q3 = quantile(AVG_SCORE, 0.75, na.rm = TRUE),
      Max = max(AVG_SCORE, na.rm = TRUE)
    ),
  
  # Standardized Grade 7 score
  panel %>%
    filter(GRADE == "07") %>%
    summarise(
      Variable = "Numeracy z-score (Grade 7)",
      Min = min(AVG_SCORE_Z, na.rm = TRUE),
      Q1 = quantile(AVG_SCORE_Z, 0.25, na.rm = TRUE),
      Median = median(AVG_SCORE_Z, na.rm = TRUE),
      Mean = mean(AVG_SCORE_Z, na.rm = TRUE),
      SD = sd(AVG_SCORE_Z, na.rm = TRUE),
      Q3 = quantile(AVG_SCORE_Z, 0.75, na.rm = TRUE),
      Max = max(AVG_SCORE_Z, na.rm = TRUE)
    ),
  
  panel_dy %>%
    summarise(
      Variable = "PM2.5 (May-Sept avg., µg/m³)",
      Min = min(pm25, na.rm = TRUE),
      Q1 = quantile(pm25, 0.25, na.rm = TRUE),
      Median = median(pm25, na.rm = TRUE),
      Mean = mean(pm25, na.rm = TRUE),
      SD = sd(pm25, na.rm = TRUE),
      Q3 = quantile(pm25, 0.75, na.rm = TRUE),
      Max = max(pm25, na.rm = TRUE)
    ),
  
  panel_dy %>%
    summarise(
      Variable = "Burned area within 50 km (ha)",
      Min = min(burned_ha, na.rm = TRUE),
      Q1 = quantile(burned_ha, 0.25, na.rm = TRUE),
      Median = median(burned_ha, na.rm = TRUE),
      Mean = mean(burned_ha, na.rm = TRUE),
      SD = sd(burned_ha, na.rm = TRUE),
      Q3 = quantile(burned_ha, 0.75, na.rm = TRUE),
      Max = max(burned_ha, na.rm = TRUE)
    ))

# Round values
table1 <- table1 %>%
  mutate(
    across(
      c(Min, Q1, Median, Mean, SD, Q3, Max),
      ~ round(.x, 1)))

# Save text version
capture.output(
  {cat("Table 1. Summary Statistics\n\n")
    print(as.data.frame(table1), row.names = FALSE)},
  file = "results/table01_summary_statistics.txt")
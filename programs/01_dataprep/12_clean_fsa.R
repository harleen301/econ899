library(readxl)
library(dplyr)
library(stringr)
library(purrr)

fsa_folder <- "data/raw_data/FSA"

files <- list.files(fsa_folder,
  pattern = "\\.xlsx$",
  full.names = TRUE)

fsa_raw <- files %>%
  map_dfr(read_excel)

fsa_clean <- fsa_raw %>%
  filter(DATA_LEVEL == "District Level") %>%
  mutate(year = as.integer(str_extract(SCHOOL_YEAR, "^\\d{4}")),
         DISTRICT_NUMBER = as.integer(DISTRICT_NUMBER)) %>%
  filter(year >= 2017,year <= 2024) %>%
  filter(DISTRICT_NUMBER != 93) %>%
  dplyr::select(year,DISTRICT_NUMBER,DISTRICT_NAME,SUB_POPULATION,GRADE,
    FSA_SKILL_CODE,NUMBER_WRITERS,AVG_SCORE,MEDIAN_SCORE,STDEV_SCORE)

fsa_num <- fsa_clean %>%
  filter(SUB_POPULATION == "All Students",
         FSA_SKILL_CODE == "Numeracy") %>%
  mutate(AVG_SCORE = na_if(AVG_SCORE, "Msk"),
         MEDIAN_SCORE = na_if(MEDIAN_SCORE, "Msk"),
         STDEV_SCORE = na_if(STDEV_SCORE, "Msk")) %>%
  mutate(AVG_SCORE = as.numeric(AVG_SCORE),
         MEDIAN_SCORE = as.numeric(MEDIAN_SCORE),
         STDEV_SCORE = as.numeric(STDEV_SCORE))


write.csv(fsa_num,
  "data/data_for_analysis/fsa_num.csv",
  row.names = FALSE)

saveRDS(fsa_num,
  "data/data_for_analysis/fsa_num.rds")

# Load data 
fsa_num <- readRDS(
  "data/data_for_analysis/fsa_num.rds")



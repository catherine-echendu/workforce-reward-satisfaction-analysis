# ============================================================
# 03_metric_build.R
# Purpose: Build job_sat_index from 7 satisfaction items.
#          Reverse-coded so 5 = most satisfied.
#          Requires at least 4 of 7 valid responses.
#          qa8f (pay satisfaction) deliberately excluded
#          to avoid circularity in modelling.
# Inputs:  00_data/processed/research_clean.rds
# Outputs: 00_data/processed/research_clean_with_index.rds
# Author:  Catherine Echendu
# Updated: 08 May 2026
# ============================================================


# ---- 1. Setup ----------------------------------------------

source("C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit/01_R/00_setup.R")


# ---- 2. Load cleaned dataset -------------------------------

research_clean <- readRDS(
  file.path(path_processed, "research_clean.rds")
)


# ---- 3. Reverse-code satisfaction items --------------------
# Original coding: 1 = very satisfied, 5 = very dissatisfied
# Reversed coding: 1 = very dissatisfied, 5 = very satisfied
# Formula: reversed = 6 - original

research_clean <- research_clean |>
  mutate(
    qa8a_rev = 6 - qa8a_clean,
    qa8b_rev = 6 - qa8b_clean,
    qa8c_rev = 6 - qa8c_clean,
    qa8d_rev = 6 - qa8d_clean,
    qa8e_rev = 6 - qa8e_clean,
    qa8g_rev = 6 - qa8g_clean,
    qa8h_rev = 6 - qa8h_clean
  )


# ---- 4. Build job satisfaction index -----------------------
# Mean of reversed items where at least 4 of 7 are valid

jsat_items <- c("qa8a_rev", "qa8b_rev", "qa8c_rev",
                "qa8d_rev", "qa8e_rev", "qa8g_rev",
                "qa8h_rev")

research_clean <- research_clean |>
  mutate(
    n_valid_jsat = rowSums(!is.na(across(all_of(jsat_items)))),
    job_sat_index = ifelse(
      n_valid_jsat >= 4,
      rowMeans(across(all_of(jsat_items)), na.rm = TRUE),
      NA_real_
    )
  )


# ---- 5. Sense check ----------------------------------------

cat("Job satisfaction index summary:\n")
print(summary(research_clean$job_sat_index))

cat("\nValid N:", sum(!is.na(research_clean$job_sat_index)), "\n")
cat("Missing N:", sum(is.na(research_clean$job_sat_index)), "\n")

cat("\nDistribution check (should be centred around 3.5 to 4):\n")
cat("Mean:", round(mean(research_clean$job_sat_index,
                        na.rm = TRUE), 3), "\n")
cat("SD:  ", round(sd(research_clean$job_sat_index,
                      na.rm = TRUE), 3), "\n")
cat("Median:", round(median(research_clean$job_sat_index,
                            na.rm = TRUE), 3), "\n")


# ---- 6. Save -----------------------------------------------

saveRDS(research_clean,
        file.path(path_processed,
                  "research_clean_with_index.rds"))

cat("\nDataset with index saved.\n")
cat("Rows:", nrow(research_clean), "\n")
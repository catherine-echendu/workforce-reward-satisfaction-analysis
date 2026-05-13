# ============================================================
# 05_descriptives_weighted.R
# Purpose: FINAL PHASE weighted descriptives.
#          Applies WERS employee weight seqwtnrc_apr13 and accounts
#          for clustering by workplace serno.
#          All headline numbers come from this script.
# Inputs:  00_data/processed/research_clean_with_index.rds 
# Outputs: 04_outputs/tables/final_job_sat_summary.csv
#          04_outputs/tables/final_pay_sat_gradient.csv
# Citation: WERS Introductory Note Section 7;
#           WERS FAQ Guide Part 6
# Author:  Catherine Echendu
# Updated: 08 May 2026
# ============================================================


# ---- 1. Setup ----------------------------------------------

source("C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit/01_R/00_setup.R")


# ---- 2. Load dataset with index ----------------------------

research_clean <- readRDS(
  file.path(path_processed, "research_clean_with_index.rds")
)


# ---- 3. Define survey design -------------------------------
# Apply WERS employee weight and cluster by workplace

wers_design <- research_clean |>
  filter(!is.na(job_sat_index)) |>
  as_survey_design(
    ids     = serno,
    weights = seqwtnrc_apr13
  )

cat("Survey design created.\n")
cat("Weighted N:", nrow(wers_design$variables), "\n")


# ---- 4. Weighted overall job satisfaction summary ----------

job_sat_weighted <- wers_design |>
  summarise(
    n         = unweighted(n()),
    mean_wtd  = survey_mean(job_sat_index, vartype = "ci"),
    median_wtd = survey_median(job_sat_index, vartype = NULL)
  )

cat("\nWeighted job satisfaction summary:\n")
print(job_sat_weighted)


# ---- 5. Weighted three-band split --------------------------

band_weighted <- wers_design |>
  mutate(
    sat_band = case_when(
      job_sat_index < 3 ~ "Low",
      job_sat_index < 4 ~ "Moderate",
      TRUE              ~ "High"
    )
  ) |>
  group_by(sat_band) |>
  summarise(
    n      = unweighted(n()),
    pct    = survey_mean(vartype = "ci")
  )

cat("\nWeighted three-band split:\n")
print(band_weighted)


# ---- 6. Weighted pay satisfaction gradient -----------------

pay_sat_weighted <- wers_design |>
  filter(!is.na(qa8f_clean)) |>
  mutate(
    pay_sat_cat = factor(
      qa8f_clean,
      levels = 1:5,
      labels = c("Very satisfied", "Satisfied",
                 "Neither", "Dissatisfied",
                 "Very dissatisfied")
    )
  ) |>
  group_by(pay_sat_cat) |>
  summarise(
    n        = unweighted(n()),
    mean_js  = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted pay satisfaction gradient:\n")
print(pay_sat_weighted)


# ---- 7. Save summary tables --------------------------------

write.csv(job_sat_weighted,
          file.path(path_tables, "final_job_sat_summary.csv"),
          row.names = FALSE)

write.csv(pay_sat_weighted,
          file.path(path_tables, "final_pay_sat_gradient.csv"),
          row.names = FALSE)

cat("\nTables saved to 04_outputs/tables/\n")


# ---- 8. Weighted job satisfaction by grouped pay band ------

pay_band_weighted <- wers_design |>
  filter(!is.na(qe11_clean)) |>
  mutate(
    pay_band_group = case_when(
      qe11_clean %in% 1:5   ~ "Lower (Bands 1-5, under £25k)",
      qe11_clean %in% 6:9   ~ "Middle (Bands 6-9, £25k-£49k)",
      qe11_clean %in% 10:14 ~ "Upper (Bands 10-14, £50k+)"
    ),
    pay_band_group = factor(
      pay_band_group,
      levels = c(
        "Lower (Bands 1-5, under £25k)",
        "Middle (Bands 6-9, £25k-£49k)",
        "Upper (Bands 10-14, £50k+)"
      )
    )
  ) |>
  group_by(pay_band_group) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by grouped pay band:\n")
print(pay_band_weighted)


# ---- 9. Weighted benefits: pension -------------------------

pension_weighted <- wers_design |>
  filter(!is.na(qe12mul6_clean)) |>
  mutate(
    pension = factor(
      qe12mul6_clean,
      levels = c(0, 1),
      labels = c("No pension", "Has pension")
    )
  ) |>
  group_by(pension) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by pension:\n")
print(pension_weighted)


# ---- 10. Weighted benefits: extra hours pay ----------------

extra_pay_weighted <- wers_design |>
  filter(!is.na(qe12mul5_clean)) |>
  mutate(
    extra_pay = factor(
      qe12mul5_clean,
      levels = c(0, 1),
      labels = c("No extra hours pay", "Has extra hours pay")
    )
  ) |>
  group_by(extra_pay) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by extra hours pay:\n")
print(extra_pay_weighted)


# ---- 11. Weighted benefits: training days ------------------

training_weighted <- wers_design |>
  filter(!is.na(qb3_clean)) |>
  mutate(
    training = factor(
      qb3_clean,
      levels = 1:6,
      labels = c(
        "No training",
        "Less than 1 day",
        "1 to 2 days",
        "3 to 5 days",
        "6 to 9 days",
        "10 or more days"
      )
    )
  ) |>
  group_by(training) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by training days:\n")
print(training_weighted)


# ---- 12. Weighted benefits: flexi-time ---------------------

flexitime_weighted <- wers_design |>
  filter(!is.na(qb1a_clean)) |>
  mutate(
    flexitime = factor(
      qb1a_clean,
      levels = 1:3,
      labels = c(
        "Uses flexi-time",
        "Available, not used",
        "Not available"
      )
    )
  ) |>
  group_by(flexitime) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by flexi-time:\n")
print(flexitime_weighted)


# ---- 13. Weighted benefits: job sharing --------------------

jobsharing_weighted <- wers_design |>
  filter(!is.na(qb1b_clean)) |>
  mutate(
    job_sharing = factor(
      qb1b_clean,
      levels = 1:3,
      labels = c(
        "Uses job sharing",
        "Available, not used",
        "Not available"
      )
    )
  ) |>
  group_by(job_sharing) |>
  summarise(
    n       = unweighted(n()),
    mean_js = survey_mean(job_sat_index, vartype = "ci")
  )

cat("\nWeighted job satisfaction by job sharing:\n")
print(jobsharing_weighted)


# ---- 14. Save all new tables -------------------------------

write.csv(pay_band_weighted,
          file.path(path_tables, "final_pay_band_summary.csv"),
          row.names = FALSE)

write.csv(pension_weighted,
          file.path(path_tables, "final_pension_summary.csv"),
          row.names = FALSE)

write.csv(extra_pay_weighted,
          file.path(path_tables, "final_extra_pay_summary.csv"),
          row.names = FALSE)

write.csv(training_weighted,
          file.path(path_tables, "final_training_summary.csv"),
          row.names = FALSE)

write.csv(flexitime_weighted,
          file.path(path_tables, "final_flexitime_summary.csv"),
          row.names = FALSE)

write.csv(jobsharing_weighted,
          file.path(path_tables, "final_jobsharing_summary.csv"),
          row.names = FALSE)

cat("\nAll benefits and pay band tables saved to 04_outputs/tables/\n")
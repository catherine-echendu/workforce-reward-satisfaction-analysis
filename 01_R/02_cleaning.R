# ============================================================
# 02_cleaning.R
# Purpose: Apply WERS missing-value rules variable by variable.
#          Set all out-of-range codes to NA. No imputation.
#          No blanket na.omit on the full dataset.
# Inputs:  00_data/raw/wers11_seq_general_use_missings_coded_numeric_july2013.dta
# Outputs: 00_data/processed/research_clean.rds
# Author:  Catherine Echendu
# Updated: 12 May 2026
# ============================================================


# ---- 1. Setup ----------------------------------------------

source("C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit/01_R/00_setup.R")


# ---- 2. Read raw file --------------------------------------

wers_raw <- read_dta(
  file.path(path_raw,
            "wers11_seq_general_use_missings_coded_numeric_july2013.dta")
)


# ---- 3. Apply NA rules -------------------------------------
# Valid ranges per WERS documentation:
# qa8a:qa8h satisfaction items: 1 to 5
# qe11 pay band: 1 to 14 (97 = multicoded, treat as NA)
# qb1a, qb1b flexible working: 1 to 3
# qb3 training days: 1 to 6
# qe12mul5, qe12mul6 benefits: 0 to 1
# qa8f pay satisfaction: 1 to 5

research_clean <- wers_raw |>
  mutate(
    
    # Job satisfaction items: valid 1 to 5
    qa8a_clean = ifelse(as.numeric(qa8a) %in% 1:5,
                        as.numeric(qa8a), NA_real_),
    qa8b_clean = ifelse(as.numeric(qa8b) %in% 1:5,
                        as.numeric(qa8b), NA_real_),
    qa8c_clean = ifelse(as.numeric(qa8c) %in% 1:5,
                        as.numeric(qa8c), NA_real_),
    qa8d_clean = ifelse(as.numeric(qa8d) %in% 1:5,
                        as.numeric(qa8d), NA_real_),
    qa8e_clean = ifelse(as.numeric(qa8e) %in% 1:5,
                        as.numeric(qa8e), NA_real_),
    qa8g_clean = ifelse(as.numeric(qa8g) %in% 1:5,
                        as.numeric(qa8g), NA_real_),
    qa8h_clean = ifelse(as.numeric(qa8h) %in% 1:5,
                        as.numeric(qa8h), NA_real_),
    
    # Pay satisfaction: valid 1 to 5 (kept separate from index)
    qa8f_clean = ifelse(as.numeric(qa8f) %in% 1:5,
                        as.numeric(qa8f), NA_real_),
    
    # Pay band: valid 1 to 14
    qe11_clean = ifelse(as.numeric(qe11) %in% 1:14,
                        as.numeric(qe11), NA_real_),
    
    # Flexible working: valid 1 to 3
    qb1a_clean = ifelse(as.numeric(qb1a) %in% 1:3,
                        as.numeric(qb1a), NA_real_),
    qb1b_clean = ifelse(as.numeric(qb1b) %in% 1:3,
                        as.numeric(qb1b), NA_real_),
    
    # Training days: valid 1 to 6
    qb3_clean  = ifelse(as.numeric(qb3)  %in% 1:6,
                        as.numeric(qb3),  NA_real_),
    
    # Benefits indicators: valid 0 to 1
    qe12mul5_clean = ifelse(as.numeric(qe12mul5) %in% 0:1,
                            as.numeric(qe12mul5), NA_real_),
    qe12mul6_clean = ifelse(as.numeric(qe12mul6) %in% 0:1,
                            as.numeric(qe12mul6), NA_real_),
    
    # Keep cluster ID as numeric
    serno    = as.numeric(serno)
  )


# ---- 4. Sense check: count NAs on cleaned variables --------

cat("Missingness check on cleaned variables:\n\n")

clean_vars <- c("qa8a_clean", "qa8b_clean", "qa8c_clean",
                "qa8d_clean", "qa8e_clean", "qa8g_clean",
                "qa8h_clean", "qa8f_clean", "qe11_clean",
                "qb1a_clean", "qb1b_clean", "qb3_clean",
                "qe12mul5_clean", "qe12mul6_clean")

N <- nrow(research_clean)

for (v in clean_vars) {
  n_miss <- sum(is.na(research_clean[[v]]))
  pct    <- round(100 * n_miss / N, 1)
  cat(v, ": missing =", n_miss, "(", pct, "%)\n")
}

# ---- 4b. Clean control variables --------------------------
# Based on WERS 2011 SEQ questionnaire:
# qa1 = A1 = Tenure at workplace (5 categories, NOT contract type)
# qa2 = A2 = Contract type (3 categories: permanent, temp, fixed)
# qa3 = A3 = Basic contracted hours per week (numeric)
# qe1 = E1 = Gender (2 categories: male, female)
# qe2 = E2 = Age (9 categories, not 7 as previously specified)

research_clean <- research_clean |>
  mutate(
    
    # Tenure: valid 1 to 5
    qa1_clean = ifelse(as.numeric(qa1) %in% 1:5,
                       as.numeric(qa1), NA_real_),
    
    # Contract type: valid 1 to 3
    qa2_clean = ifelse(as.numeric(qa2) %in% 1:3,
                       as.numeric(qa2), NA_real_),
    
    # Basic contracted hours: numeric, valid 1 to 97
    qa3_clean = ifelse(as.numeric(qa3) > 0 &
                         as.numeric(qa3) < 98,
                       as.numeric(qa3), NA_real_),
    
    # Gender: valid 1 to 2
    qe1_clean = ifelse(as.numeric(qe1) %in% 1:2,
                       as.numeric(qe1), NA_real_),
    
    # Age: valid 1 to 9 (corrected from 1:7)
    qe2_clean = ifelse(as.numeric(qe2) %in% 1:9,
                       as.numeric(qe2), NA_real_)
  )

cat("\nControl variable missingness (corrected):\n")
for (v in c("qa1_clean","qa2_clean","qa3_clean",
            "qe1_clean","qe2_clean")) {
  n_miss <- sum(is.na(research_clean[[v]]))
  pct    <- round(100 * n_miss / nrow(research_clean), 1)
  cat(v, ": missing =", n_miss, "(", pct, "%)\n")
}


# ---- 5. Save cleaned dataset -------------------------------

saveRDS(research_clean,
        file.path(path_processed, "research_clean.rds"))

cat("\nCleaned dataset saved to 00_data/processed/research_clean.rds\n")
cat("Rows:", nrow(research_clean), "\n")
cat("Columns:", ncol(research_clean), "\n")
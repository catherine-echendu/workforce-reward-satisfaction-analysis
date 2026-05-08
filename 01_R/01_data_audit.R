# ============================================================
# 01_data_audit.R
# Purpose: Inspect the raw WERS file. Confirm shape, key
#          variable names, and basic coding before cleaning.
# Inputs:  00_data/raw/wers11_seq_general_use_missings_coded_numeric.dta
# Outputs: console only. No files saved.
# Author:  Catherine Echendu
# Updated: 08 May 2026
# ============================================================


# ---- 1. Setup ----------------------------------------------

source("C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit/01_R/00_setup.R")


# ---- 2. Read raw file --------------------------------------

wers_raw <- read_dta(
  file.path(path_raw,
            "wers11_seq_general_use_missings_coded_numeric_july2013.dta")
)


# ---- 3. Confirm shape --------------------------------------

cat("Rows:", nrow(wers_raw), "\n")
cat("Columns:", ncol(wers_raw), "\n")


# ---- 4. Confirm key variables exist ------------------------

key_vars <- c(
  "qa8a", "qa8b", "qa8c", "qa8d", "qa8e", "qa8f",
  "qa8g", "qa8h",
  "qe11",
  "qb1a", "qb1b",
  "qb3",
  "qe12mul5", "qe12mul6",
  "seqwtnrc_apr13",
  "serno"
)

cat("\nKey variable check:\n")
for (v in key_vars) {
  exists <- v %in% names(wers_raw)
  cat(v, ":", ifelse(exists, "FOUND", "MISSING"), "\n")
}


# ---- 5. Quick look at satisfaction items -------------------

cat("\nSample values for qa8a (first satisfaction item):\n")
print(table(as.numeric(wers_raw$qa8a), useNA = "ifany"))

cat("\nSample values for seqwtnrc_apr13 (employee weight):\n")
print(summary(as.numeric(wers_raw$seqwtnrc_apr13)))
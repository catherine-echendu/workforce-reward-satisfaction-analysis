# ============================================================
# 00_setup.R
# Purpose: Load libraries, set project paths, set global options.
#          Run this script first in every working session.
# Author:  Catherine Echendu
# Updated: 08 May 2026
# ============================================================


# ---- 1. Libraries ------------------------------------------

library(haven)      # read WERS .dta file
library(dplyr)      # data manipulation
library(tidyr)      # reshaping
library(forcats)    # factor handling
library(ggplot2)    # visualisation
library(srvyr)      # survey-weighted analysis


# ---- 2. Project paths --------------------------------------

# Set this to your WERS_Revisit folder location
project_root <- "C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit"

path_raw       <- file.path(project_root, "00_data", "raw")
path_processed <- file.path(project_root, "00_data", "processed")
path_tables    <- file.path(project_root, "04_outputs", "tables")
path_figures   <- file.path(project_root, "04_outputs", "figures")


# ---- 3. Global options -------------------------------------

options(scipen = 999)
options(stringsAsFactors = FALSE)


# ---- 4. Confirm paths exist --------------------------------

cat("Checking project paths:\n")
cat("Raw data folder exists:", dir.exists(path_raw), "\n")
cat("Processed folder exists:", dir.exists(path_processed), "\n")
cat("Tables folder exists:", dir.exists(path_tables), "\n")
cat("Figures folder exists:", dir.exists(path_figures), "\n")


# ---- 5. Session info (run at end of session) ---------------

# Uncomment and run this at the end of each working session:
# sessionInfo()
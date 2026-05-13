# ============================================================
# 06_modelling.R
# Purpose: Weighted regression to rank reward levers.
#          Decision-tree to identify at-risk segments.
# Inputs:  00_data/processed/research_clean_with_index.rds
# Outputs: 04_outputs/tables/model_coefficients.csv
#          04_outputs/tables/model_decision_tree.csv
# Author:  Catherine Echendu
# Updated: 11 May 2026
# ============================================================


# ---- 1. Setup ----------------------------------------------

source("C:/Users/ellae/Desktop/Data Portfolio/MSc_Project_Revisit/WERS_Revisit/01_R/00_setup.R")
library(survey)
library(broom)
library(rpart)
library(rpart.plot)


# ---- 2. Load data ------------------------------------------

research_clean <- readRDS(
  file.path(path_processed, "research_clean_with_index.rds")
)


# ---- 3. Data preparation -----------------------------------
# Add grouped pay band variable before defining survey design

research_clean <- research_clean |>
  mutate(
    pay_band_group = case_when(
      qe11_clean %in% 1:5   ~ 1,
      qe11_clean %in% 6:9   ~ 2,
      qe11_clean %in% 10:14 ~ 3
    )
  )


# ---- 4. Define survey design and run regression ------------
# Outcome: job_sat_index
# Predictors: pay satisfaction, grouped pay band,
#             five benefit levers, five controls

wers_design <- svydesign(
  ids     = ~serno,
  weights = ~seqwtnrc_apr13,
  data    = research_clean |>
    filter(!is.na(job_sat_index))
)

cat("Survey design created.\n")
cat("N:", nrow(wers_design$variables), "\n")

model_main <- svyglm(
  job_sat_index ~
    qa8f_clean +
    pay_band_group +
    qe12mul6_clean +
    qe12mul5_clean +
    qb3_clean +
    qb1a_clean +
    qb1b_clean +
    qe1_clean +
    qe2_clean +
    qa1_clean +
    qa2_clean +
    qa3_clean,
  design = wers_design
)

cat("\nRegression summary:\n")
print(summary(model_main))


# ---- 5. Extract and save coefficients ----------------------

coef_table <- tidy(model_main, conf.int = TRUE) |>
  filter(term != "(Intercept)") |>
  mutate(
    term = recode(term,
                  "qa8f_clean"    = "Pay satisfaction",
                  "pay_band_group"= "Pay band (grouped)",
                  "qe12mul6_clean"= "Pension",
                  "qe12mul5_clean"= "Extra hours pay",
                  "qb3_clean"     = "Training days",
                  "qb1a_clean"    = "Flexi-time",
                  "qb1b_clean"    = "Job sharing",
                  "qe1_clean"     = "Gender (control)",
                  "qe2_clean"     = "Age (control)",
                  "qa1_clean" = "Tenure (control)",
                  "qa3_clean"     = "Hours worked (control)", 
                  "qa2_clean"     = "Contract type (control)"
    )
  ) |>
  arrange(desc(abs(estimate)))

cat("\nCoefficient table (sorted by effect size):\n")
print(coef_table)

write.csv(coef_table,
          file.path(path_tables, "model_coefficients.csv"),
          row.names = FALSE)

cat("\nCoefficients saved.\n")


# ---- 6. Decision tree for segment identification -----------

tree_data <- research_clean |>
  filter(!is.na(job_sat_index)) |>
  mutate(
    low_sat = ifelse(job_sat_index < 3, 1, 0)
  ) |>
  select(
    low_sat, qa8f_clean, pay_band_group,
    qe12mul6_clean, qe12mul5_clean, qb3_clean,
    qb1a_clean, qb1b_clean,
    qe1_clean, qe2_clean, qa1_clean, qa2_clean, qa3_clean
  ) |>
  na.omit()

cat("\nDecision tree sample N:", nrow(tree_data), "\n")

tree_model <- rpart(
  low_sat ~ .,
  data   = tree_data,
  method = "class",
  control = rpart.control(
    cp      = 0.005,
    maxdepth = 4
  )
)

cat("\nDecision tree summary:\n")
printcp(tree_model)

rpart.plot(
  tree_model,
  type  = 2,
  extra = 104,
  main  = "Employee segments at risk of low job satisfaction"
)

tree_rules <- as.data.frame(tree_model$frame)
write.csv(tree_rules,
          file.path(path_tables, "model_decision_tree.csv"),
          row.names = TRUE)

cat("\nDecision tree saved.\n")

# Save decision tree as a larger PNG file
png(
  file.path(path_figures, "model_decision_tree.png"),
  width  = 1600,
  height = 1000,
  res    = 150
)
rpart.plot(
  tree_model,
  type   = 2,
  extra  = 104,
  main   = "Employee segments at risk of low job satisfaction",
  cex    = 0.8
)
dev.off()

cat("Decision tree plot saved to 04_outputs/figures/\n")
# 02_SQL

SQL validation queries for the WERS analysis pipeline.

## Why SQL is used in this project

Every analytical result produced in R is independently verified 
using SQL before it is reported. This is not a formality. It is 
how analysts in commercial and regulated environments build 
confidence in their numbers before presenting to senior 
stakeholders.

If R and SQL produce the same result, the finding is robust. 
If they diverge, there is something worth investigating before 
any recommendation is made. That discipline is what separates 
a trustworthy analysis from one that just looks right.

## What these queries do

- `01_validate_counts.sql` — confirms row counts and valid N 
  for the job satisfaction index match between R and the raw data.
- `02_validate_job_sat_means.sql` — reproduces weighted group 
  means by pay satisfaction category. Cross-checks the headline 
  finding that employees very satisfied with pay score 
  substantially higher on job satisfaction than those very 
  dissatisfied.
- `03_validate_pay_sat_gradient.sql` — confirms the stepwise 
  pay satisfaction gradient independently of R.

## How weighted means are validated in SQL

Weighted group means are calculated as:

SUM(outcome_value * weight) / SUM(weight)

This mirrors the srvyr weighted analysis in R and uses the WERS 
employee weight SEQWTNRC throughout.

## Results

All cross-tool checks and their outcomes are logged in 
03_QA/qa_validation_log.xlsx.

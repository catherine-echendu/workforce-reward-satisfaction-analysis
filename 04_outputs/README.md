# 04_outputs

Final, report-ready outputs exported from the R analysis pipeline.

## Why this folder exists

Keeping outputs separate from code is a discipline that matters
in commercial analytics. It means anyone reviewing this project
can go directly to the results without running any code, and it
means the report and dashboard always pull from a single,
trusted source rather than from scattered files.

Every file in this folder is produced by a numbered R script
in 01_R/. Nothing is manually edited after export. If a number
looks wrong, the fix goes into the R script and the output is
regenerated. That is the audit trail.

## Structure

**tables/**
CSV exports of final weighted summary tables and regression
results. These feed directly into the Word report and the
Power BI dashboard.

Examples of files that will appear here:
- `final_job_sat_summary.csv` — weighted overall descriptives
- `final_pay_sat_gradient.csv` — weighted mean job satisfaction
  by pay satisfaction category
- `final_pay_band_summary.csv` — weighted mean job satisfaction
  by grouped pay band
- `final_benefits_summary.csv` — weighted job satisfaction by
  each benefit lever
- `model_coefficients.csv` — regression coefficients, standard
  errors, and p-values from the final weighted model

**figures/**
PNG exports of final weighted charts. Consistent palette,
accessible labels, report-ready formatting.

Examples of files that will appear here:
- `final_pay_sat_chart.png`
- `final_pay_band_chart.png`
- `final_benefits_chart.png`
- `model_coefficient_plot.png`

## What is not in this folder

Draft and exploratory outputs from the unweighted phase are
not kept here. They served their purpose during exploration
and are superseded by the weighted final outputs. Only
final-phase outputs are committed to this folder.

# 01_R

R scripts for the WERS analysis pipeline.

## Why R

R is used as the analytical engine for this project because it 
handles survey-weighted analysis natively through the srvyr 
package, supports reproducible pipelines through numbered scripts, 
and produces publication-ready outputs that feed directly into 
the Power BI dashboard and the Word report.

Every result produced in R is independently verified in SQL 
before it is reported. That cross-tool validation discipline 
is documented in 02_SQL/ and logged in 03_QA/.

## Script order

Run scripts in numerical order. Each script has a clear input 
and output documented at the top.

| Script | Purpose |
|---|---|
| `00_setup.R` | Libraries, project paths, global options, sessionInfo for reproducibility |
| `01_data_audit.R` | Raw file inspection, variable classes, baseline checks before cleaning |
| `02_cleaning.R` | WERS missing-value rules applied per variable, cleaned dataset saved |
| `03_metric_build.R` | job_sat_index built from 7 reverse-coded satisfaction items; pay satisfaction excluded to avoid circularity in modelling |
| `04_descriptives_draft.R` | Unweighted exploratory descriptives, retained as draft baseline only |
| `05_descriptives_weighted.R` | Final weighted descriptives using WERS employee weight SEQWTNRC, clustering by workplace serno |
| `06_modelling.R` | Weighted regression to rank reward levers by association strength; decision-tree modelling to identify employee segments most at risk of low satisfaction |
| `07_outputs.R` | Final report-ready tables and figures exported to 04_outputs/ |

## Weighting approach

All final outputs use the WERS employee weight SEQWTNRC per 
WERS guidance:

1. WERS 2011 Introductory Note (UKDA Study 7226), Section 7
2. WERS 2011 FAQ Guide, Part 6

The unweighted draft outputs in `04_descriptives_draft.R` are 
retained as the exploration baseline. They are not reported as 
findings.

## Modelling approach

Two complementary methods are used:

**Weighted regression** ranks the reward levers (pay satisfaction, 
pay band, pension, extra hours pay, training, flexi-time, job 
sharing) by their strength of association with job satisfaction, 
controlling for employee characteristics. This answers: which 
levers matter most?

**Decision-tree modelling** identifies which combinations of 
employee characteristics and reward access are most associated 
with low satisfaction. This answers: which groups are most at 
risk and where should the employer act first?

Together these give a Head of People Analytics both a ranked 
lever list and a targeted segment view, which is what a 
constrained reward budget decision actually requires.

## What is not in this folder

Raw data, processed datasets, and model objects are not 
committed to this repository. The WERS microdata is licensed 
by the UK Data Service and cannot be redistributed. All data 
files are gitignored. See 00_data/ for the data governance note.

# R analysis scripts

Numbered pipeline scripts for the full analysis. Run in order.
Each script sources 00_setup.R at the top.

**Status: Complete through 06_modelling.R — 07_outputs.R pending (Power BI phase)**

## Script sequence

| Script | Purpose | Status |
|---|---|---|
| 00_setup.R | Libraries, project paths, global options | Complete |
| 01_data_audit.R | Raw file audit: row counts, variable checks, weight confirmation | Complete |
| 02_cleaning.R | Apply WERS NA rules variable by variable; clean benefit, pay and control variables | Complete |
| 03_metric_build.R | Build job_sat_index from seven satisfaction items; apply ≥4-of-7 rule | Complete |
| 04_descriptives_draft.R | Unweighted draft descriptives (draft phase only; superseded by 05) | Draft — kept for audit trail |
| 05_descriptives_weighted.R | Final weighted descriptives for all five benefit levers and pay variables | Complete |
| 06_modelling.R | Weighted regression and decision-tree segment identification | Complete |
| 07_outputs.R | Final report-ready tables and figures for Word and Power BI | Pending |

## Key design decisions

- Weight variable: `seqwtnrc_apr13` (WERS employee weight, as given in the data)
- Clustering: `serno` (workplace ID) in all survey designs
- Package for weighted analysis: `srvyr` (descriptives), `survey` (regression)
- Decision tree: `rpart` with `cp = 0.005`, `maxdepth = 4`

## Outputs

Saved to `04_outputs/tables/` and `04_outputs/figures/`.
All processed data files are gitignored per UKDS End User Licence.

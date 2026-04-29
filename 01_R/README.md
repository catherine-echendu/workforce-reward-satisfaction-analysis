# 01_R

R scripts for the WERS analysis pipeline. Each script is numbered 
to reflect the order of execution. Run 00_setup.R first in every 
working session.

## Scripts

- `00_setup.R` — libraries, project paths, global options, 
  sessionInfo for reproducibility.
- `01_data_audit.R` — raw file inspection, variable classes, 
  baseline checks before cleaning.
- `02_cleaning.R` — WERS missing-value rules applied, cleaned 
  variables created, processed dataset saved.
- `03_metric_build.R` — job_sat_index constructed from 7 reverse-coded 
  satisfaction items. Pay satisfaction (qa8f) excluded to avoid 
  circularity in modelling.
- `04_descriptives_draft.R` — unweighted exploratory descriptives. 
  Draft phase only. Retained as exploration baseline.
- `05_descriptives_weighted.R` — final phase weighted descriptives 
  using WERS employee weight SEQWTNRC, clustering by workplace serno.
- `06_modelling.R` — weighted regression of job_sat_index on pay 
  and benefits levers with controls.
- `07_outputs.R` — final report-ready tables and figures exported 
  to 04_outputs/.

## Weighting approach

All final outputs use the WERS employee weight SEQWTNRC per WERS 
guidance (WERS Introductory Note, Section 7; WERS FAQ Guide, Part 6).

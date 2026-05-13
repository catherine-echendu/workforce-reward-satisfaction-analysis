# 00_data

Data governance folder for the WERS workforce reward and satisfaction analysis.

## Purpose

This folder stores the local raw and processed data files used during the analysis.

The files in this folder are kept locally and are not uploaded to GitHub.

## Folder structure

- `raw/` contains the original WERS 2011 Survey of Employees data file downloaded from the UK Data Service.
- `processed/` contains local processed analysis files created from the raw data, including RDS and CSV working files.

## Data source

This project uses the WERS 2011 Survey of Employees, accessed via the UK Data Service under End User Licence.

Department for Business, Innovation and Skills, Advisory, Conciliation and Arbitration Service and National Institute of Economic and Social Research (2015) *Workplace Employee Relations Survey, 2011* [data collection]. 6th Release. UK Data Service. SN: 7226. Available at: http://doi.org/10.5255/UKDA-SN-7226-7 (Accessed: 8 May 2026).

## Governance rule

Raw and processed microdata must not be committed to GitHub.

The WERS data is accessed under the UK Data Service End User Licence. The raw microdata cannot be redistributed. Only code, documentation, methodology notes and non-sensitive aggregated outputs are included in the public repository.

## GitHub rule

The following are gitignored and must remain local only:

- `raw/`
- `processed/`
- `.dta`
- `.rds`
- `.csv` files containing row-level data
# 00_data

This folder holds the WERS 2011 Survey of Employees data files.

## Structure

- `raw/` — the original WERS .dta file as downloaded from the UK Data 
  Service. This folder is gitignored and will never appear in this 
  repository. Raw microdata cannot be shared under the UKDS End User 
  Licence.
- `processed/` — cleaned datasets written by R scripts during analysis. 
  Also gitignored. Not committed to the repository.

## Data source

Department for Business, Innovation and Skills (2013) Workplace 
Employment Relations Survey, 2011 [computer file]. Colchester, Essex: 
UK Data Archive [distributor], February 2013. SN: 7226. 
http://dx.doi.org/10.5255/UKDA-SN-7226-1

Researchers wishing to reproduce this analysis must obtain the data 
directly from the UK Data Service at https://ukdataservice.ac.uk

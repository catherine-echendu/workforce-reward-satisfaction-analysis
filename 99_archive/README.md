# 99_archive

Historical and superseded versions of project files.

## Why this folder exists

In a real analytical project, work evolves. Scripts get
restructured, approaches get refined, and earlier versions
get superseded by stronger ones. Deleting that history
entirely loses something useful: the evidence of how the
project developed and why decisions were made.

This folder preserves that history without cluttering the
active pipeline. Nothing here is used in the current
analysis. Everything here has a successor in the numbered
folders above.

## Contents

**Research_Revisit_legacy.R**
The original master script from the first phase of this
revisit project, before the pipeline was restructured into
numbered scripts in 01_R/. It contains the initial cleaning
logic, the job satisfaction index construction, and the
unweighted exploratory descriptives that form the draft
baseline documented in the methodology log.

It is kept here for three reasons. First, it shows the
analytical thinking that preceded the current structure.
Second, it is the source from which the numbered scripts
in 01_R/ were built. Third, it demonstrates the kind of
iterative, improvement-focused workflow that characterises
senior analytical practice: not throwing away earlier work,
but understanding it well enough to build something stronger
from it.

## What is not here

Local WERS data files and restricted derived outputs have
been deleted from the working environment in line with the
UKDS End User Licence clause 17, following confirmation
that the registered access period had ended. This covers
the raw .dta file, cleaned .rds datasets, and any
individual-level derived outputs.

The R scripts are retained because they contain code only,
not data. No WERS microdata was ever committed to this
repository. The .gitignore at the root enforces this
automatically.

Fresh access to WERS 2011 has been applied for under a
new personal user registration with the UK Data Service.
Analysis will resume once access is confirmed.

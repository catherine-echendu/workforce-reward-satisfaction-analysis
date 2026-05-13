# WERS Revisit: Park List

**Project:** Workforce Reward and Satisfaction Analysis
**Created:** 28 April 2026
**Last updated:** 12 May 2026
**Purpose:** Records items deliberately not being worked on 
now, with a clear reason and a trigger for when each item 
becomes active. Nothing here is forgotten. Everything has 
a defined moment when it re-enters the workflow.

---

## Parked items

**P1: Decision 2 — frozen benefits lever list (Path A vs B)**

What it is: the decision on whether to carry five benefit levers into the analysis (pension, extra hours pay, training, flexi-time, job sharing) or add performance bonus variables as a sixth lever.

Why parked: all four setup artefacts needed to be locked first. GitHub structure also needed to be complete.

Trigger to unpark: first thing in the next analysis session, immediately after UKDS access is confirmed.

**COMPLETED: 08 May 2026. Path A locked. Five levers confirmed. Performance bonus parked as P15.**

---


**P2: Grouped pay band rule**

What it is: the decision on how to collapse the 14 WERS pay bands into an HR-readable grouped variable for stakeholder charts (lower, middle, upper, or tercile-based groupings).

Why parked: will be decided at the start of the weighted rerun so the grouping is applied consistently from the first weighted output.

Trigger to unpark: start of the staged weighted rerun in R, after Decision 2 is locked.

**COMPLETED: 08 May 2026. D3 locked. Three tiers confirmed:
Lower Bands 1-5, Middle Bands 6-9, Upper Bands 10-14. Anchored to ONS ASHE 2023 median earnings.**

---

**P3: Staged weighted rerun in R**

What it is: re-running the existing descriptive outputs using the WERS employee weight SEQWTNRC and clustering by workplace serno, per the locked Option B decision.

Why parked: UKDS access reapplication submitted 29 April 2026. Awaiting approval (up to 3 working days). Cannot run analysis without data.

Trigger to unpark: immediately after UKDS access is confirmed and data is downloaded.

Sequence when unparked: overall descriptives first, then pay satisfaction, then pay band, then benefits. One block at a time, with SQL cross-check after each block.

**COMPLETED: 08 May 2026. Weighted descriptives complete for overall satisfaction, pay satisfaction gradient, grouped pay bands, and all five benefit levers. Eight CSV files saved to 04_outputs/tables/.**

---

**P4: SQL validation queries**

What it is: three to four short SQL queries that reproduce key R results independently (row counts, weighted group means, the pay satisfaction gradient).

Why parked: SQL validation runs in parallel with the weighted rerun. Writing queries before the weighted R outputs exist would mean validating the wrong numbers.

Trigger to unpark: after the first weighted descriptive block is confirmed in R.

**COMPLETED: 12 May 2026.**
19 validation checks run across all five benefit levers and headline findings. All passed. Maximum difference 0.005.
Validation scope extended beyond original 12 checks to cover all five benefit levers per real-life standards. Full results logged in 03_QA/qa_validation_log.xlsx.

---

**P5: Modelling specification**

What it is: the decision on which regression model or models to run (single-lever models, combined model, robustness check, controls list) plus the decision-tree modelling specification for segment identification.

Why parked: modelling decisions should follow from the weighted descriptives, not precede them.

Trigger to unpark: after all weighted descriptives are confirmed and locked.

**COMPLETED: 13 May 2026.**
Weighted regression complete and final control-variable alignment confirmed. Regression includes corrected controls: gender, age, tenure, contract type and contracted hours. Pay satisfaction remains the dominant predictor (−0.298***). Training remains the strongest positive benefit lever (+0.097***). Decision tree rerun with `qa2_clean` included as a candidate input. Final tree sample N = 15,655. Selected split variables remained stable: pay satisfaction, training, contracted hours and job sharing. Highest-risk segment: very pay-dissatisfied, low training, 26+ contracted hours, no job sharing — 4% of workforce, 60% low satisfaction probability.

---

**P6: Power BI page structure and build**

What it is: the design and build of the four-page stakeholder dashboard (overview, pay, benefits, QA and method).

Why parked: Power BI needs final, locked numbers to display.

Trigger to unpark: after modelling is complete and all final outputs are saved to 04_outputs/.

---

**P7: Commercial translation financial model paragraph**

What it is: a short paragraph and supporting table in the executive summary translating regression findings into an approximate turnover cost saving.

Why parked: cannot be written until regression coefficients exist.

Trigger to unpark: after modelling is complete.

**STATUS: IN PROGRESS from 12 May 2026.**
Commercial translation paragraph has been drafted as working material, but has not yet been reviewed, inserted into the Word report, or checked against the final report narrative.

---

**P8: Full README for GitHub**

What it is: completing the GitHub README with full project findings, headline results, and final recommendations.

Why parked: the README tells the story of a finished project. The current version is a strong placeholder. It will be completed when the project is substantially finished.

Trigger to unpark: after Power BI and executive summary are complete.

**STATUS: IN PROGRESS from 12 May 2026.**
The root README has been substantially updated earlier than originally planned and now reflects the current project story, tool stack, governance position and project status. It is not yet final because the Word report, Power BI dashboard, executive summary and final recommendations are still pending.

---

**P9: GitHub repository final polish**

What it is: uploading remaining local files to GitHub (park_list.md, R scripts as they are completed, SQL queries, final outputs).

Why parked: files are uploaded as each analytical block is completed, not all at once.

Trigger to unpark: ongoing, starting next session. First upload: park_list.md to repository root.

---

**P10: Code hygiene pass**

What it is: trimming unused libraries from R scripts, adding sessionInfo() to 00_setup.R, checking numbered scripts are consistent with the methodology log.

Why parked: code hygiene is done once, at the end, not piecemeal throughout.

Trigger to unpark: after all R analysis is complete and before the GitHub repo goes live as a finished portfolio piece.

---

**P11: Section 2 Word report placeholders**

What it is: three remaining placeholders in Section 2 of the
Word report: survey weights decision wording, proxy variable wording, and changes from the original MSc analysis section.

Why parked: weights decision is locked but the Section 2 paragraph has not been drafted yet. Will be written during the weighted rerun phase.

Trigger to unpark: during or after the weighted rerun, when Section 2 is being finalised alongside the updated numbers.

**STATUS: ACTIVE from 12 May 2026.**
Weighted descriptives, SQL validation and modelling are now complete. Section 2 report placeholders should be resolved before the report is treated as near-final. This includes the survey weights paragraph, proxy-variable wording and changes from the original MSc analysis.

---

**P12: GitHub social preview image**

What it is: a clean, text-based social preview image (1280 x 640 pixels) showing the project name, role title, and tool stack. Appears when the repo link is shared on LinkedIn or in emails.

Why parked: build the content first, polish the presentation last.

Trigger to unpark: after Power BI dashboard and executive summary are complete.

How to do it: use Canva (free, browser-based). Upload via GitHub repository Settings, Social preview section.

---

**P13: Update WERS citation across GitHub**

What it is: replace the 2013 citation (SN-7226-1) with the correct current citation (6th release, SN-7226-7) in three places: root README.md, 00_data/README.md, and methodology_log.md.

Correct citation to use:
Department for Business, Innovation and Skills, Advisory, Conciliation and Arbitration Service and National Institute of Economic and Social Research (2015) Workplace Employee Relations Survey, 2011 [data collection]. 6th Release. UK
Data Service. SN: 7226. Available at: http://doi.org/10.5255/UKDA-SN-7226-7 (Accessed: 08 May 2026)

Why parked: citation confirmed from UKDS page on 29 April 2026. Update deferred to avoid piecemeal commits at end of a long session.

Trigger to unpark: first thing in the next GitHub session,before any new content is added.

**STATUS: IN PROGRESS from 12 May 2026.**
Correct WERS 2011 6th Release citation has been added to the root README and is being checked across the remaining project documentation. A new `00_data/README.md` is being created so the data folder also carries the citation and governance rule. Mark complete only after root README, `00_data/README.md` and
`methodology_log.md` are confirmed locally and committed to GitHub.

---

**P14: Add Power BI dashboard screenshot to LinkedIn project entry**

What it is: a screenshot of Power BI Page 1 (overview page) added as media to the LinkedIn project entry.

Why parked: dashboard does not exist yet.

Trigger to unpark: after Power BI Page 1 is complete.

---

**P15: Performance bonus variables as future extension**

What it is: test qe12mul2, qe12mul3, qe12mul4 as an additional reward layer in the regression model after the MVP analysis is complete.

Why parked: Decision 2 locked as Path A (five levers). Performance bonus adds coding complexity without improving the MVP story.

Trigger to unpark: after MVP modelling is complete and the five-lever model is validated.

---

P16: Original vs Revisit detailed flow section

What it is: review and update the detailed flow section in original_vs_revisit_log.xlsx so it reflects the final rebuilt project process, weighted analysis, SQL validation, modelling and reporting workflow.

Why parked: the summary table is now updated, but the detailed narrative should only be revised once the Word report, Power BI dashboard and final GitHub structure are closer to completion.

Trigger to unpark: after the Word report draft is updated and before final GitHub polish.

---

## Completed items

**P1: Decision 2 — frozen benefits lever list**
Completed: 08 May 2026. Path A locked. Five levers confirmed. Performance bonus parked as P15.

**Data audit and cleaning (not a parked item, milestone record):**
Completed: 08 May 2026. Raw file confirmed, cleaning applied, research_clean.rds saved.

**Metric build (not a parked item, milestone record):**
Completed: 08 May 2026. job_sat_index built, mean 3.629, research_clean_with_index.rds saved.

**P2: Grouped pay band rule (D3)**
Completed: 08 May 2026. Lower Bands 1-5 (under £25k), Middle Bands 6-9 (£25k-£49k), Upper Bands 10-14 (£50k+).
Reference: ONS ASHE 2023.

**P3: Staged weighted rerun in R**
Completed: 08 May 2026. All weighted descriptives produced. Eight CSV files in 04_outputs/tables/.

**P4: SQL validation queries**
Completed: 12 May 2026. 19 validation checks run across all five benefit levers and headline findings. All passed. Maximum difference 0.005. Results in 03_QA/qa_validation_log.xlsx.

**P5: Modelling specification**
Completed: 13 May 2026. Weighted regression and final decision-tree alignment complete. Corrected controls included. Final tree sample N = 15,655. Business interpretation stable: highest-risk segment remains very pay-dissatisfied, low training, 26+ contracted hours and no job sharing.

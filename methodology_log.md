# WERS Revisit: Methodology Log (v2)

**Project:** Impact of Pay and Benefits on Job Satisfaction (Revisit)
**Analyst:** Catherine Echendu
**Last updated:** 14 May 2026
**Purpose:** Single source of truth for every methodology decision in this project. Captures what is locked, what is pending, and the reasoning behind each choice. Updated whenever a new decision is made.

---

## 1. Project framing

**Stakeholder:** Head of People Analytics / HR Director, large UK service-sector employer (500+ employees).

**Business question (locked, working version):**
If a large UK employer can improve only a small number of reward levers in the next 12–24 months, which changes to pay, pay experience, and key benefits are most likely to improve employee job satisfaction?

**Commercial translation (locked, artefact 3, 28 Apr 2026):**
If a large UK employer can improve only a small number of reward
levers in the next 12 to 24 months, which changes to pay, pay
experience, and key benefits are most strongly associated with
higher employee job satisfaction, and what does that imply for
retention risk and reward investment priorities?

**Project phase framing (locked):**
- *Draft phase* = exploratory, unweighted analysis (current Sections 3–5 of the Word report).
- *Final phase* = WERS-compliant, weighted analysis. All headline numbers and modelling come from this phase.

**Current report status:** Word report Sections 1 to 5 drafted
at draft-phase standard. Weighted descriptive analysis, SQL
validation and modelling are complete, with one controlled
decision-tree rerun pending after final control-variable alignment.
Benefits sections, executive summary, Power BI dashboard and
final portfolio outputs still need to be completed.

---

## 2. Data

**Source:** WERS 2011 Survey of Employees, accessed via the UK Data Service under End User Licence. Raw microdata will not be shared publicly; only code, documentation, and non-sensitive derived outputs will be included in any portfolio repository.

**Raw file:** 21,981 employees × 151 variables.

**Unit of analysis:** Individual employee, clustered within workplace (`serno`).

**08 May 2026 update:**

Raw WERS SEQ file opened successfully in R. Dataset confirmed as 21,981 rows, 151 variables.
All 16 key analysis variables found. 
Weight variable confirmed as `seqwtnrc_apr13` in this file version.
Final R and SQL validation scripts use `seqwtnrc_apr13` directly. 

Cleaning applied variable by variable per locked NA rules. Negative WERS missing codes and out-of-range values set to NA.No blanket row deletion used. Cleaned dataset saved as research_clean.rds with 21,981 rows and 166 columns. 

Most variables low missingness. 
Flexi-time (qb1a_clean, 10.9%) and job sharing (qb1b_clean, 17.5%) had higher missingness and will be interpreted with caution in reporting.

---

## 3. Outcome metric (locked)

**Variable:** `job_sat_index`

**Construction:**
- Built from 7 satisfaction items: `qa8a`, `qa8b`, `qa8c`, `qa8d`, `qa8e`, `qa8g`, `qa8h`.
- Items reverse-coded so 5 = most satisfied, using `6 − x`.
- Index = mean of available reversed items, requiring at least 4 of 7 valid responses.
- Pay satisfaction (`qa8f`) is deliberately excluded to avoid circularity when used as a predictor.

**Locked descriptives (unweighted draft):**
N = 21,784 · mean = 3.63 · SD = 0.74 · median = 3.71 · IQR = 3.14 to 4.14
Bands: Low (<3) 16.4% · Moderate (3 to <4) 46.2% · High (≥4) 37.4%

**Status:** Will be re-run weighted in the final phase. Numbers expected to shift slightly; pattern expected to hold.

**08 May 2026 update:**

Job satisfaction index (job_sat_index) rebuilt in R pipeline. 
Confirmed: valid N 21,784, missing 197 (0.9%), mean 3.629, median 3.714, SD 0.740. 
Matches draft mean of 3.63 closely, confirming cleaning and metric logic are consistent.
Weighted final mean 3.65 (CI 3.62 to 3.67). 
All final outputs use weighted version. Dataset saved as research_clean_with_index.rds..

---

## 4. Survey weights (locked, Option B)

**Decision:** Apply the WERS employee weight `SEQWTNRC` for all final descriptive and modelling outputs. Account for clustering by workplace (`serno`).

**Tooling:** R package `srvyr` for weighted analysis. SQL for cross-validation using `SUM(value * weight) / SUM(weight)`.

**Citation sources for the methodology defence:**
1. WERS 2011 Introductory Note (UKDA Study 7226), Section 7 "Weighting variables".
2. WERS 2011 FAQ Guide, Part 6 "Weighting and statistical inference".

**Rationale:** WERS guidance is explicit that weighting is advisable for the Survey of Employees, especially for regression. Following the data provider's own analytical guidance is the most defensible final-output position.

**Rerun strategy:** Staged, not big-bang.
1. Overall job satisfaction descriptives (Table 1, Figure 1, three-band split).
2. Pay satisfaction descriptives (Table 3, Figure 3).
3. Pay band descriptives (Table 4, Figure 4).
4. Benefits descriptives, weighted from the start.
5. Modelling, weighted.

08 May 2026 
Weight variable confirmed as `seqwtnrc_apr13` in the WERS SEQ file used for this analysis. Final weighted descriptives, modelling and SQL validation use `seqwtnrc_apr13` directly.

**SQL validation scope (confirmed 12 May 2026):**
19 cross-tool checks were run covering:
- Overall weighted mean (1 check)
- Pay satisfaction gradient, all 5 categories (5 checks)
- Training gradient, all 6 categories (6 checks)
- Pension access, both categories (2 checks)
- Extra hours pay access, both categories (2 checks)
- Flexi-time access, all 3 categories (3 checks)

Scope rationale: checks were initially run on the three findings the business recommendations rest on: overall mean, pay satisfaction, and training. Scope was then extended to cover all five benefit levers to align with real-life validation standards. All 19 checks passed. Maximum difference between R and SQL was 0.005, treated as rounding difference from floating point arithmetic. Results are documented in `03_QA/qa_validation_log.xlsx`.

**Decision tree stability check (13 May 2026):**
After correcting and adding `qa2_clean` as the contract type variable, the decision tree was rerun with contract type included as a candidate input. The sample changed slightly from 15,670 to 15,655 because rows with missing candidate inputs are removed from the tree model. The selected splitting variables remained unchanged: pay satisfaction, training, contracted hours and job sharing. The highest-risk segment and business interpretation therefore remain stable.

---

## 5. Pay variables (locked)

**Subjective pay (pay satisfaction):** `qa8f_clean`, kept separate from `job_sat_index` for use as a predictor. Valid range 1–5.

**Objective pay (pay band):** `qe11_clean`, 14 ordered bands. To be supplemented with an HR-readable grouped pay band variable for stakeholder-facing analysis. The final grouping rule will be specified during the rerun phase.

**D3 locked: 08 May 2026**
Grouped pay band rule confirmed. Three tiers based on UK
earnings distribution (ONS ASHE 2023):
- Lower: Bands 1 to 5 (under approximately £25,000)
- Middle: Bands 6 to 9 (approximately £25,000 to £49,999)
- Upper: Bands 10 to 14 (£50,000 and above)
Reference: ONS Annual Survey of Hours and Earnings 2023.

Weighted results: Lower 3.72, Middle 3.57, Upper 3.68.
U-shape confirmed. Middle earners show lowest satisfaction.

---


## 6. Benefits levers (locked, Decision 2, Path A)

**Original status before 08 May 2026:** Pending Decision 2.
Five candidate levers were identified: pension (qe12mul6_clean),
extra hours pay (qe12mul5_clean), training (qb3_clean),
flexi-time (qb1a_clean), job sharing (qb1b_clean).
Performance bonus (qe12mul2/3/4) was also under consideration
as Path B.
**DECISION LOCKED: 08 May 2026**

**Locked lever set (5 levers):**
- **Core benefits (3):** pension (`qe12mul6_clean`), extra hours pay
  (`qe12mul5_clean`), training (`qb3_clean`).
- **Flexible working items (2):** flexi-time (`qb1a_clean`), job
  sharing (`qb1b_clean`).

**Rationale:** Path A keeps the analysis focused, interpretable,
and suitable for a portfolio MVP. These five levers are
understandable to HR and operational stakeholders, require no
additional cleaning work, and allow the project to move into
weighted analysis, SQL validation, and dashboarding efficiently.

**Future extension (parked as P15):** test performance bonus
variables `qe12mul2`, `qe12mul3`, `qe12mul4` as an additional
reward layer after the MVP analysis is complete..

---

## 7. Missing-value handling (locked)

For all variables: any value outside the documented valid range, including `−9` (refusal), `−8` (don't know), `−6` (multi-coded), `−2` (schedule N/A), `−1` (item N/A), and code `97` for pay band, is set to `NA`. No imputation. Index requires ≥4 of 7 valid items.

---

## 8. Tool stack (planned final delivery stack)

| Layer | Tool | Status |
|---|---|---|
| Cleaning, indexing, modelling | R / RStudio | In use |
| Weighted analysis | R `srvyr` package | In use |
| Cross-tool validation | SQL / PostgreSQL | Complete for weighted descriptives |
| Stakeholder delivery | Power BI | Planned next |
| Documentation | Word + GitHub README | Word in use; README in progress |

Excluded by design: cloud / Azure / Fabric. Not a genuine fit for this project.

---

## 9. Project documentation set

This project is operationally managed using **four documents only**. The methodology log records the documentation system itself, so the system is auditable.

| # | Document | Format | Updated when | Status |
|---|---|---|---|---|
| 1 | Methodology log | Markdown (`methodology_log.md`) | A methodology decision is made or changed | Locked v2 |
| 2 | Daily work log (Did / Learned / Next) | Excel | End of each working session | In use |
| 3 | Original vs Revisit log | Excel | A deliberate departure from the original MSc analysis is made | In use |
| 4 | QA / validation log | Excel | Any cross-tool or cross-method check is run | In use; 19 SQL validation checks logged |

**Deliberately excluded documents and rationale:**

The following documents exist on real corporate projects but are **deliberately not used** on this project. They would constitute admin theatre at the cost of analytical time, on a solo portfolio project with no team and no external stakeholders.

- **Risks log:** used in formal corporate / regulated programmes to track delivery, financial, and compliance risks. Not applicable to a solo analytical portfolio project. Methodological risks are captured directly in this methodology log under each decision's rationale, which is the right home for them.
- **Stakeholder log:** used to track multiple real stakeholders, their interests, and engagement cadence. This project has one fictional advisory stakeholder (Head of People Analytics). A separate log would add no information.
- **Meetings log:** used to record decisions taken in meetings. This project has no meetings. Decisions are recorded directly in Section 11 of this log.
- **Sprint board:** used in agile team delivery to coordinate work across multiple people. A solo project with a single workstream does not need one. The Daily work log already captures Did / Learned / Next, which is the same function at the right scale.

**Principle:** four documents is the ceiling. More than that becomes admin theatre and competes with analytical time. Each document above earns its place by serving a distinct, recurring purpose.

---

## 10. Decisions still pending

*This table shows only currently unresolved decisions.
Completed decisions are recorded permanently in Section 11.*

| # | Decision | Status |
|---|---|---|
| D5 | Power BI page structure | Deferred to dashboard phase: active next |
| D8 | GitHub repo setup | Active: push after documentation complete |

*Resolved since last update:*
*D2 (benefits lever list): locked 08 May 2026.*
*D3 (grouped pay band rule): locked 08 May 2026.*
*D4 (modelling specification): complete 11 May 2026. Regression and decision tree both done.*
*D6 (commercial translation paragraph): paragraph drafted 12 May 2026. Pending: Catherine to paste into Word report executive summary and confirm. Not yet marked complete.*
*D7 (folder structure and script labels): in progress. 01_R README.md created and folder audit under way. Final code hygiene checks still pending before GitHub commit.*

---

## 11. Decision log (chronological)

| Date | Decision | Outcome |
|---|---|---|
| 20 Nov 2025 | Business framing reframed as HR advisory brief | Locked |
| 24 Nov 2025 | Outcome index excludes `qa8f` | Locked |
| 25 Nov 2025 | Missing-value rules applied per WERS codes | Locked |
| 27 Nov 2025 | Three-band satisfaction grouping | Locked |
| 05 Dec 2025 | Pay satisfaction descriptives | Locked (draft) |
| 06 Dec 2025 | Pay band descriptives | Locked (draft) |
| 27 Apr 2026 | Survey weights = Option B | Locked |
| 27 Apr 2026 | Two-source citation strategy | Locked |
| 27 Apr 2026 | Project phase framing: draft → final | Locked |
| 27 Apr 2026 | Staged rerun strategy adopted | Locked |
| 27 Apr 2026 | Planned final delivery stack defined (R, SQL, Excel, Power BI) | Locked |
| 27 Apr 2026 | Project documentation set defined (4 documents) | Locked |
| 28 Apr 2026 | Commercial translation paragraph locked (artefact 3). CIPD (2024) and WERS UKDS citation confirmed as reference sources. | Locked |
| 28 Apr 2026 | Park list locked (artefact 4). 11 deferred items documented with triggers. | Locked |
| 08 May 2026 | Benefits lever list locked: Path A, five levers. Performance bonus parked as future extension (P15). | Locked |
| 08 May 2026 | Raw data confirmed: 21,981 rows, 151 variables, all key variables found | Confirmed |
| 08 May 2026 | Weight variable confirmed as `seqwtnrc_apr13` in the WERS SEQ file used for this analysis. Final weighted descriptives, modelling and SQL validation use `seqwtnrc_apr13` directly. | Confirmed |
| 08 May 2026 | Cleaning script run: research_clean.rds saved, 166 columns | Confirmed |
| 08 May 2026 | job_sat_index built: mean 3.629, valid N 21,784 | Confirmed |
| 08 May 2026 | D3 locked: grouped pay bands Lower/Middle/Upper, ONS ASHE 2023 anchor | Locked |
| 08 May 2026 | Training confirmed as strongest benefit lever: 3.46 to 4.00 range | Confirmed |
| 11 May 2026 | wers_employees table created in PostgreSQL wers_project. wers_validation.csv imported (21,981 rows, 10 columns). | Confirmed |
| 11 May 2026 | SQL validation run: 12 checks across overall mean, pay satisfaction gradient (5 categories), training gradient (6 categories). All passed. Maximum difference 0.004. | Confirmed |
| 11 May 2026 | Control variable cleaning corrected after checking WERS SEQ questionnaire. qa1=tenure (1:5), qa2=contract type (1:3), qe2=age (1:9). All five controls under 4% missing. | Confirmed |
| 11 May 2026 | Weighted regression complete. Pay satisfaction dominant predictor (-0.298***). Training strongest positive lever (+0.097***). | Confirmed |
| 11 May 2026 | Initial decision tree completed. Highest-risk segment identified: very pay-dissatisfied, low training, 26+ contracted hours, no job sharing. 4% of workforce, 60% low satisfaction probability. One controlled rerun pending after final control-variable alignment check. | Confirmed |
| 12 May 2026 | SQL validation scope extended to cover all five benefit levers. Three additional checks added: pension (2 categories), extra hours pay (2 categories), flexi-time (3 categories). Total checks: 19. All passed. Maximum difference 0.005. | Confirmed |
| 12 May 2026 | Validation scope decision documented: initial 12 checks covered headline findings. Extended to 19 to align with real-life standards and cover all five benefit levers. Rationale recorded in methodology log Section 4. | Confirmed |
| 12 May 2026 | D6 drafted: commercial translation paragraph prepared using regression findings and CIPD 2024 turnover-cost framing. Pending final insertion into Word report executive summary and review against final report wording. | In progress |
| 12 May 2026 | D7 in progress: folder structure and script labels under audit. 01_R/README.md created. Weight variable confirmed as `seqwtnrc_apr13` in current weighted descriptives and modelling scripts. Final code hygiene checks still in progress before GitHub commit. | In progress |
| 13 May 2026 | Decision tree rerun after final control-variable alignment. `qa2_clean` (contract type) was added to the candidate tree inputs. Final decision tree sample N = 15,655. The selected splitting variables remained pay satisfaction, training, contracted hours and job sharing. Updated `model_decision_tree.csv` and `model_decision_tree.png` saved to `04_outputs/`. | Confirmed |

---

**Document control:** Updated immediately when a methodology decision is made or changed. Older entries are not deleted; superseded decisions are marked with date and reason.
